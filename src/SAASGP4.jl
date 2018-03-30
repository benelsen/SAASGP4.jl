
module SAASGP4

using Compat

# include("deps.jl")

if isfile(joinpath(dirname(@__FILE__),"..","deps","deps.jl"))
    include("../deps/deps.jl")
else
    error("SAASGP4 not properly installed. Please run Pkg.build(\"SAASGP4\")")
end

function __init__()
    mainHandle = mainInit()

    sgp4SetLicFilePath(normpath(joinpath(@__DIR__, "../deps/usr/lib/")))

    envInit(mainHandle)
    astroFuncInit(mainHandle)
    timeFuncInit(mainHandle)
    tleInit(mainHandle)
    sgp4Init(mainHandle)
end

# Main

"""
    mainInit()

Returns a handle which can be used to access the static global data set needed by the Standardized Astrodynamic Algorithms DLLs to communicate among themselves
"""
function mainInit()
    ccall((:DllMainInit, dllmain), Clonglong, ())
end
const dllMainInit = mainInit


"""
    getLastErrMsg()

Returns a character string describing the last error that occurred
"""
function getLastErrMsg()
    msg = repeat(" ", 128)
    ccall((:GetLastErrMsg, dllmain), Nothing, (Cstring,), msg)
    strip(msg)
end

"""
    getLastInfoMsg()

Returns a character string describing the last informational message that was recorded
"""
function getLastInfoMsg()
    msg = repeat(" ", 128)
    ccall((:GetLastInfoMsg, dllmain), Nothing, (Cstring,), msg)
    strip(msg)
end

"""
    mainGetInfo()

Returns information about the DllMain DLL
"""
function mainGetInfo()
    msg = repeat(" ", 128)
    ccall((:DllMainGetInfo, dllmain), Nothing, (Cstring,), msg)
    strip(msg)
end
const dllMainGetInfo = mainGetInfo

"""
    getInitDllNames()

Returns a list of names of the Standardized Astrodynamic Algorithms DLLs that were initialized successfully
"""
function getInitDllNames()
    msg = repeat(" ", 512)
    ccall((:GetInitDllNames, dllmain), Nothing, (Cstring,), msg)
    strip(msg)
end

"""
    openLogFile(path)

Opens a log file and enables the writing of diagnostic information into it
"""
function openLogFile(path)
    ccall((:OpenLogFile, dllmain), Cint, (Cstring,), path)
end

"""
    closeLogFile()

Closes the currently open log file
"""
function closeLogFile()
    ccall((:CloseLogFile, dllmain), Nothing, ())
end


# EnvConst

"""
    envInit(mainHandle::Clonglong)

Initializes the EnvInit DLL for use in the program
"""
function envInit(mainHandle::Clonglong)
    errCode = ccall((:EnvInit, envconst), Clonglong, (Clonglong,), mainHandle)
    if errCode != 0
        error(getLastErrMsg())
    end
end

"""
    envGetInfo()

Returns information about the EnvConst DLL
"""
function envGetInfo()
    msg = repeat(" ", 128)
    ccall((:EnvGetInfo, envconst), Nothing, (Cstring,), msg)
    strip(msg)
end

"""
    envGetGeoStr()

Returns the name of the current Earth constants (GEO) model
"""
function envGetGeoStr()
    msg = repeat(" ", 6)
    ccall((:EnvGetGeoStr, envconst),
        Nothing,
        (Cstring,),
        msg)
    strip(msg)
end

"""
    envSetGeoStr(geoStr)

Changes the Earth constants (GEO) setting to the model specified by a string literal
"""
function envSetGeoStr(geoStr)
    ccall((:EnvSetGeoStr, envconst),
        Nothing,
        (Cstring,),
        geoStr)
end

"Returns the current Earth constants (GEO) setting"
function envGetGeoIdx()
    ccall((:EnvGetGeoIdx, envconst),
        Cint,
        ())
end

"""
    envSetGeoIdx(id)

Changes the Earth constants (GEO) setting to the specified value
"""
function envSetGeoIdx(id)
    ccall((:EnvSetGeoIdx, envconst),
        Nothing,
        (Cint,),
        id)
end

"""
    envGetGeoConst(id)

Retrieves the value of one of the constants from the current Earth constants (GEO) model
"""
function envGetGeoConst(id)
    ccall((:EnvGetGeoConst, envconst),
        Cdouble,
        (Cint,),
        id)
end

"Returns the current fundamental catalogue (FK) setting"
function envGetFkIdx()
    ccall((:EnvGetFkIdx, envconst),
        Cint,
        ())
end

"""
    envSetFkIdx(id)

Changes the fundamental catalogue (FK) setting to the specified value
"""
function envSetFkIdx(id)
    ccall((:EnvSetFkIdx, envconst),
        Nothing,
        (Cint,),
        id)
end

"""
    envGetFkConst(id)

Retrieves the value of one of the constants from the current fundamental catalogue (FK) model
"""
function envGetFkConst(id)
    ccall((:EnvGetFkConst, envconst),
        Cdouble,
        (Cint,),
        id)
end

"""
    envGetFkPtr()

Returns a handle that can be used to access the fundamental catalogue (FK) data structure
"""
function envGetFkPtr()
    ccall((:EnvGetFkPtr, envconst),
        Clonglong,
        ())
end

"""
    envLoadFile(path)

Reads Earth constants (GEO) model and fundamental catalogue (FK) model settings from a file
"""
function envLoadFile(path)
    retval = ccall((:EnvSaveFile, envconst),
        Cint,
        (Cstring,),
        path)
    if retval != 0
        error(getLastErrMsg())
    end
end

"""
    envSaveFile(path, append = 0, format = 0)

Saves the current Earth constants (GEO) model and fundamental catalogue (FK) model settings to a file
"""
function envSaveFile(path, append = 0, format = 0)
    retval = ccall((:EnvSaveFile, envconst),
        Cint,
        (Cstring, Cint, Cint),
        path,
        append,
        format)
    if retval != 0
        error(getLastErrMsg())
    end
end


# AstroFunc

"""
    astroFuncInit(mainHandle)

Initializes AstroFunc DLL for use in the program
"""
function astroFuncInit(mainHandle)
    errCode = ccall((:AstroFuncInit, astrofunc), Clonglong, (Clonglong,), mainHandle)
    if errCode != 0
        error(getLastErrMsg())
    end
end


# TimeFunc

"""
    timeFuncInit(mainHandle)

Initializes the TimeFunc DLL for use in the program
"""
function timeFuncInit(mainHandle)
    errCode = ccall((:TimeFuncInit, timefunc), Clonglong, (Clonglong,), mainHandle)
    if errCode != 0
        error(getLastErrMsg())
    end
end

"""
    DTGToUTC(dtg)

Converts a time in one of the DTG formats to a time in ds50UTC. DTG15, DTG17, DTG19, and DTG20 formats are accepted
"""
function DTGToUTC(dtg)
    ccall((:DTGToUTC, timefunc), Cdouble, (Cstring,), dtg)
end


# TLE

"""
    tleInit(mainHandle)

Initializes Tle DLL for use in the program
"""
function tleInit(mainHandle)
    errCode = ccall((:TleInit, tle), Clonglong, (Clonglong,), mainHandle)
    if errCode != 0
        error(getLastErrMsg())
    end
end

"""
    tleAddSatFrLines(line1, line2)

Adds a TLE (satellite), using its directly specified first and second lines
"""
function tleAddSatFrLines(line1, line2)
    satkey = ccall((:TleAddSatFrLines, tle),
        Clonglong,
        (Cstring, Cstring),
        line1, line2)
end

"""
    tleRemoveSat(satkey)

Removes a TLE represented by the satKey from memory
"""
function tleRemoveSat(satkey)
    errCode = ccall((:TleRemoveSat, tle),
        Cint,
        (Clonglong,),
        satkey)
    if errCode != 0
        error(getLastErrMsg())
    end
end

"""
    tleRemoveAllSats()

Removes all the TLEs from memory
"""
function tleRemoveAllSats()
    errCode = ccall((:TleRemoveAllSats, tle),
        Cint,
        ())
    if errCode != 0
        error(getLastErrMsg())
    end
end


# SGP4Prop

"""
    sgp4Init(mainHandle)

Initializes the Sgp4 DLL for use in the program
"""
function sgp4Init(mainHandle)
    errCode = ccall((:Sgp4Init, sgp4prop), Clonglong, (Clonglong,), mainHandle)
    if errCode != 0
        error(getLastErrMsg())
    end
end

"""
    sgp4SetLicFilePath(licFilePath)

Initializes the Sgp4 DLL for use in the program
"""
function sgp4SetLicFilePath(licFilePath)
    ccall((:Sgp4SetLicFilePath, sgp4prop),
        Nothing,
        (Cstring,),
        licFilePath)
end

"""
    sgp4InitSat(satkey)

Initializes an SGP4 satellite from an SGP or SGP4 TLE
"""
function sgp4InitSat(satkey)
    errCode = ccall((:Sgp4InitSat, sgp4prop),
        Clong,
        (Clonglong,),
        satkey)
    if errCode != 0
        error(getLastErrMsg())
    end
end

"""
    sgp4RemoveSat(satkey)

Removes a satellite, represented by the satKey, from the set of satellites
"""
function sgp4RemoveSat(satkey)
    retval = ccall((:Sgp4RemoveSat, sgp4prop),
        Cint,
        (Clonglong,),
        satkey)
    if retval != 0
        error(getLastErrMsg())
    end
end

"""
    sgp4RemoveAllSats(satkey)

Removes all currently loaded satellites from memory
"""
function sgp4RemoveAllSats(satkey)
    retval = ccall((:Sgp4RemoveAllSats, sgp4prop),
        Cint,
        ())
    if retval != 0
        error(getLastErrMsg())
    end
end

"""
    sgp4PropDs50UTC(satkey, ds50UTC)

Propagates a satellite, represented by the satKey, to the time expressed in days since 1950, UTC
"""
function sgp4PropDs50UTC(satkey, ds50UTC)
    pos = Array{Cdouble, 1}(undef, 3)
    vel = Array{Cdouble, 1}(undef, 3)
    llh = Array{Cdouble, 1}(undef, 3)
    mse = Ref{Cdouble}(0.0)

    retval = ccall((:Sgp4PropDs50UTC, sgp4prop),
        Cint,
        (Clonglong, Cdouble, Ref{Cdouble}, Ref{Cdouble}, Ref{Cdouble}, Ref{Cdouble}),
        satkey,     ds50UTC, mse,          pos,          vel,          llh)
    if retval != 0
        error(getLastErrMsg())
    end

    pos, vel, llh, mse[]
end

"""
    sgp4PropDs50UTC!(satkey, ds50UTC, pos, vel, llh, mse)

Propagates a satellite, represented by the satKey, to the time expressed in days since 1950, UTC
"""
function sgp4PropDs50UTC!(satkey, ds50UTC, pos, vel, llh, mse)
    retval = ccall((:Sgp4PropDs50UTC, sgp4prop),
        Cint,
        (Clonglong, Cdouble, Ref{Cdouble}, Ref{Cdouble}, Ref{Cdouble}, Ref{Cdouble}),
        satkey,     ds50UTC, mse,          pos,          vel,          llh)
    if retval != 0
        error(getLastErrMsg())
    end
end

"""
    sgp4PropMse(satkey, mse)

Propagates a satellite, represented by the satKey, to the time expressed in minutes since the satellite's epoch time
"""
function sgp4PropMse(satkey, mse)
    pos = Array{Cdouble, 1}(undef, 3)
    vel = Array{Cdouble, 1}(undef, 3)
    llh = Array{Cdouble, 1}(undef, 3)
    ds50UTC = Ref{Cdouble}(0.0)

    retval = ccall((:Sgp4PropMse, sgp4prop),
        Cint,
        (Clonglong, Cdouble, Ref{Cdouble}, Ref{Cdouble}, Ref{Cdouble}, Ref{Cdouble}),
        satkey,     mse,     ds50UTC,      pos,          vel,          llh)
    if retval != 0
        error(getLastErrMsg())
    end

    pos, vel, llh, ds50UTC[]
end

"""
    sgp4PropMse!(satkey, mse, pos, vel, llh, ds50UTC)

Propagates a satellite, represented by the satKey, to the time expressed in minutes since the satellite's epoch time.
Stores the results in the provided variables.

# Examples
```julia-repl
julia> pos = Array{Cdouble, 1}(undef, 3)
3-element Array{Float64,1}:
 0.0
 0.0
 0.0

julia> vel = Array{Cdouble, 1}(undef, 3)
3-element Array{Float64,1}:
 0.0
 0.0
 0.0

julia> llh = Array{Cdouble, 1}(undef, 3)
3-element Array{Float64,1}:
 0.0
 0.0
 0.0

julia> ds50UTC = Ref{Cdouble}(0.0)
Base.RefValue{Float64}(0.0)

julia> SAASGP4.sgp4PropMse!(satkey, mse, pos, vel, llh, ds50UTC)

julia> pos
3-element Array{Float64,1}:
 42155.0257401623
   980.5342672211367
    -9.307135121360039

julia> vel
3-element Array{Float64,1}:
 -0.07133558166329691
  3.07373221015029
 -0.0018402927526264539

julia> llh
3-element Array{Float64,1}:
    -0.012659361941212956
    34.46169610621692
 35788.29393717118

julia> ds50UTC[]
18314.489312984446
```
"""
function sgp4PropMse!(satkey, mse, pos, vel, llh, ds50UTC)
    retval = ccall((:Sgp4PropMse, sgp4prop),
        Cint,
        (Clonglong, Cdouble, Ref{Cdouble}, Ref{Cdouble}, Ref{Cdouble}, Ref{Cdouble}),
        satkey,     mse,     ds50UTC,            pos,          vel,          llh)
    if retval != 0
        error(getLastErrMsg())
    end
end

end # module
