# Flakes
A policy for managing dependencies between Nix expressions.\
An experimental feature in Nix, implementing that policy and supporting functionality.

## What are flakes?
Technically, a flake is a file system tree that contains a file named `flake.nix` in its root directory.\
Flakes add the following behavior to Nix:
+ A `flake.nix` file enforces a schema, where:
    + Other flakes are referenced as dependencies providing Nix language code or other files.
    + The values produced by the Nix expressions in `flake.nix` are structured according to pre-defined use cases.
+ References to other flakes can be specified using a dedicated URL-like syntax.\
  A flake registry allows using symbolic identifiers for further brevity.\
  References can be automatically locked to their current specific version and later updated programmatically.
+ A new command line interface, implemented as a separate experimental feature, leverages flakes by accepting flake references in order to build, run, or deploy software defined as a flake.

Nix handles flakes differently than regular Nix files in the following ways:
+ The `flake.nix` file is checked for schema validity.\
  In particular, the metadata fields cannot be arbitrary Nix expressions.\
  This is to prevent complex, possibly non-terminating computations while querying the metadata.
+ The entire flake directory is copied to Nix store before evaluation.\
  This allows for effective evaluation caching, which is relevant for large expressions such as Nixpkgs, but also requires copying the entire flake directory again on each change.
+ No external variables, parameters, or impure language values are allowed.\
  It means full reproducibility of a Nix expression, and, by extension, the resulting build instructions by default, but also prohibits parameterisation of results by consumers.

## Why are flakes controversial?
Flakes were inspired by Shea Levy’s NixCon 2018 talk, formally proposed in RFC 49, and have been in development since 2019.\
Nix introduced the implementation as its first experimental feature in 2021.\
The subject is considered controversial among Nix users and developers in terms of design, implementation quality, and decision making process.\
In particular:
+ The RFC was closed without conclusion, and some fundamental issues are not yet resolved. For example:
  + The notion of a global flake registry saw substantial criticism that was never addressed.\
    While the source references of registry entries can be pinned, local registry names in Nix expressions introduce mutable system state and are thus, in that regard, no improvement over channels as managed by `nix-channel`.
  + It is impossible to parameterise flakes.\
    This means that flakes downgrade ease of use of the system parameter of derivations, for producers and consumers.
  + The flakes proposal was criticised for trying to solve too many problems at once and at the wrong abstraction layer.\
    Part of this is that the new command line interface and flakes are closely tied to each other.
+ As predicted by RFC reviewers, the original implementation introduced regressions in the Nix 2.4 release, breaking some stable functionality without a major version increment.
+ Copying sources to the Nix store prior to evaluation adds a significant performance penalty, especially for large repositories such as Nixpkgs.\
  Work to address this has been in progress since May 2022, but risks introducing its own set of issues.
+ New Nix users were and still are encouraged by various individuals to adopt flakes despite there being no stability guarantees and no timeline to conclude the experiment.

This led to a situation where the stable interface was only sparsely maintained for multiple years, and repeatedly suffered breakages due to ongoing development.\
Meanwhile, the new interface was adopted widely enough for evolving its design without negatively affecting users to become very challenging.\
As of the 2023 survey, 84% of the respondents rely on experimental features.\
Nixpkgs as a contrasting example, while featuring a `flake.nix` for compatibility, does not depend on Nix experimental features in its code base.

## Should I use flakes in my project?
Flakes emphasize reproducible artifacts and convenience for their consumers, while classic Nix tools center around composable building blocks and customisation options for developers.\ 
Both paradigms have their own set of unique concepts and support tooling that have to be learned, with varying ease of use, implementation quality, and support status.\
At the moment, neither the stable nor the experimental interface is clearly superior to the other in all aspects.\
Flakes and the `nix` command suite bring multiple improvements that are relevant for both software users and package authors:
+ The new command-line interface, together with flakes, makes dealing with existing packages significantly more convenient in many cases.
+ The constraints imposed on flakes strengthen reproducibility by default, and enable some performance improvements when interacting with a large Nix package repository like Nixpkgs.
+ Flake references allow for easier handling of version upgrades for existing packages or project dependencies.
+ The flake schema helps with composing Nix projects from multiple sources in an orderly fashion.

At the same time, flakes have fundamental architectural issues and a number of problems with the implementation, and there is no coordinated effort to resolve them systematically.\
There are also still many open design questions around the nix command line interface, some of which are currently being worked on.\
While flakes reduce complexity in some regards, they also introduce some with additional mechanisms.\
You will have to learn more about the system to fully understand how it works.\
Other than that, and below the surface of the flake schema, Nix and the Nix language work exactly the same in both cases.\
In principle, the same level of reproducibility can be achieved with or without flakes.\
In particular, the process of adding software to Nixpkgs or maintaining NixOS modules and configurations is not affected by flakes at all.\
There is also no evidence that flakes could help solving the scalability challenges of either.\
Finally, there are downsides to relying on experimental features in general:
Interfaces and behavior of experimental features could still be changed by Nix developers.\ This may require you to adapt your code at some point in the future, which will be more effort when it has grown in complexity.\
Currently there is no concrete timeline for stabilising flakes.\
In contrast, stable features in Nix can be considered stable indefinitely.\
The Nix maintainer team focuses on fixing bugs and regressions in stable interfaces, supporting well-understood use cases, as well as improving the internal design and overall contributor experience in order to ease future development.\
Improvements to experimental features have low priority.\
The Nix documentation team focuses on improving documentation and learning materials for stable features and common principles.\
When using flakes, you will have to rely more heavily on user-to-user support, third-party documentation, and the source code.