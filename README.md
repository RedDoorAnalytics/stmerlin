# stmerlin

Parametric and semi-parametric survival models in Stata, optionally on multiple timescales.

`stmerlin` is a convenience wrapper for [`merlin`](https://github.com/RedDoorAnalytics/merlin). It fits the survival models most often needed with a short syntax, and hands the estimation to `merlin`.

## What it fits

After `stset`, `stmerlin` fits:

- **Standard parametric models**: exponential, Weibull, Gompertz, log normal, log logistic and generalised gamma, and a piecewise-exponential model.
- **Flexible parametric models**: the Royston-Parmar model, with restricted cubic splines of log time on the log cumulative hazard scale, and spline-based models on the log hazard and hazard scales.
- **The Cox model**, with an optional Firth correction.
- **Time-dependent effects**, through restricted cubic splines of log time or time (not with the log normal, log logistic or generalised gamma models).
- **Relative survival (excess hazard) models**, given the expected event rate at each event time.
- **Multiple timescales**: up to four additional timescales (`time2()` to `time5()`), each modelled with restricted cubic splines.

The linear predictor accepts `merlin`'s extended syntax, so splines and fractional polynomials of continuous covariates can be written directly in the model.

After estimation, `predict` gives survival, hazard, cumulative hazard and cumulative incidence functions, restricted mean survival time and time lost, and differences and ratios of these between covariate patterns, with confidence intervals. Predictions can be standardised over the covariates.

## Requirements

- Stata 15.1 or later.
- `merlin` 2.5.0:

```stata
net install merlin, from("https://reddooranalytics.se/install/stata/merlin/2.5.0/")
```

## Installation

```stata
net install stmerlin, from("https://raw.githubusercontent.com/RedDoorAnalytics/stmerlin/main/")
```

## Example

```stata
webuse brcancer, clear
stset rectime, failure(censrec) scale(365)

// a Royston-Parmar flexible parametric model
stmerlin hormon, distribution(rp) df(3)

// a Cox model
stmerlin hormon, distribution(cox)

// a Cox model with a time-dependent effect, using splines
stmerlin hormon, distribution(cox) tvc(hormon) dftvc(3)
```

Further detail is in the help files: `help stmerlin` and `help stmerlin postestimation`.

## Version

Version 1.1.2 (19 September 2024).

## Author and licence

Michael J. Crowther (Red Door Analytics, Stockholm) — `michael.crowther@reddooranalytics.se`.

Licence: **GPL-3.0-or-later** — see [`LICENSE`](LICENSE).

Copyright (C) 2023-2026 Red Door Analytics.

> **Licence change, 2026-10-09.** stmerlin was distributed under the MIT licence from its first
> public commit (2023-08-16) until this change. It is **GPL-3 going forward**, as is
> the rest of the family. This is not retroactive: versions already released under
> MIT remain MIT for those versions.
