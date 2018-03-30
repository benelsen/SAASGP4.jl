# SAASGP4

[![Build Status](https://travis-ci.org/benelsen/SAASGP4.jl.svg?branch=master)](https://travis-ci.org/benelsen/SAASGP4.jl)
[![codecov.io](http://codecov.io/github/benelsen/SAASGP4.jl/coverage.svg?branch=master)](http://codecov.io/github/benelsen/SAASGP4.jl?branch=master)
[![Coverage Status](https://coveralls.io/repos/benelsen/SAASGP4.jl/badge.svg?branch=master&service=github)](https://coveralls.io/github/benelsen/SAASGP4.jl?branch=master)

<!--
[![](https://img.shields.io/badge/docs-stable-blue.svg)](https://benelsen.github.io/SAASGP4.jl/stable/)
-->
[![](https://img.shields.io/badge/docs-latest-blue.svg)](https://benelsen.github.io/SAASGP4.jl/latest/)

## Installation

```julia
Pkg.add("https://github.com/benelsen/SAASGP4.jl")
```

<!--
```julia
Pkg.add("SAASGP4")
```
-->

## Usage

```julia
using SAASGP4

# load the TLE using strings
satkey = SAASGP4.tleAddSatFrLines(
    "1 90021U RELEAS14 00051.47568104 +.00000184 +00000+0 +00000-4 0 0814",
    "2 90021   0.0222 182.4923 0000720  45.6036 131.8822  1.00271328 1199")

# initialize the loaded TLE
SAASGP4.sgp4InitSat(satkey)

# parse the start time from a DTG string into a float of days since 1950
starttime = SAASGP4.DTGToUTC("00051.47568104")

# initialize the arrays to store the propagated positions, velocities etc.
poss = Array{Array{Float64, 1}, 1}()
vels = Array{Array{Float64, 1}, 1}()
llhs = Array{Array{Float64, 1}, 1}()
mses = Array{Float64, 1}()

# propagate the TLE for 10 days in 1/2 day increments
for ds50UTC in starttime:0.5:(starttime + 10)
    pos, vel, llh, mse = SAASGP4.sgp4PropDs50UTC(satkey, ds50UTC)
    push!(poss, pos)
    push!(vels, vel)
    push!(llhs, llh)
    push!(mses, mse)
end

# remove the TLE from memory
SAASGP4.sgp4RemoveSat(satkey)
SAASGP4.tleRemoveSat(satkey)
```
