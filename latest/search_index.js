var documenterSearchIndex = {"docs": [

{
    "location": "index.html#",
    "page": "Home",
    "title": "Home",
    "category": "page",
    "text": ""
},

{
    "location": "index.html#SAASGP4.jl-1",
    "page": "Home",
    "title": "SAASGP4.jl",
    "category": "section",
    "text": "Wrapper for the Standardized Astrodynamic Algorithms SGP4 Library"
},

{
    "location": "index.html#Manual-1",
    "page": "Home",
    "title": "Manual",
    "category": "section",
    "text": "Pages = [\n    \"guide.md\",\n]\nDepth = 1"
},

{
    "location": "index.html#Library-1",
    "page": "Home",
    "title": "Library",
    "category": "section",
    "text": "Pages = [\"lib.md\"]"
},

{
    "location": "index.html#main-index-1",
    "page": "Home",
    "title": "Index",
    "category": "section",
    "text": "Pages = [\"lib.md\"]"
},

{
    "location": "guide.html#",
    "page": "Guide",
    "title": "Guide",
    "category": "page",
    "text": ""
},

{
    "location": "guide.html#Guide-1",
    "page": "Guide",
    "title": "Guide",
    "category": "section",
    "text": ""
},

{
    "location": "guide.html#Installation-1",
    "page": "Guide",
    "title": "Installation",
    "category": "section",
    "text": "Pkg.add(\"https://github.com/benelsen/SAASGP4.jl\")<!–Pkg.add(\"SAASGP4\")–>"
},

{
    "location": "guide.html#Usage-1",
    "page": "Guide",
    "title": "Usage",
    "category": "section",
    "text": "using SAASGP4\n\n# load the TLE using strings\nsatkey = SAASGP4.tleAddSatFrLines(\n    \"1 90021U RELEAS14 00051.47568104 +.00000184 +00000+0 +00000-4 0 0814\",\n    \"2 90021   0.0222 182.4923 0000720  45.6036 131.8822  1.00271328 1199\")\n\n# initialize the loaded TLE\nSAASGP4.sgp4InitSat(satkey)\n\n# parse the start time from a DTG string into a float of days since 1950\nstarttime = SAASGP4.DTGToUTC(\"00051.47568104\")\n\n# initialize the arrays to store the propagated positions, velocities etc.\nposs = Array{Array{Float64, 1}, 1}()\nvels = Array{Array{Float64, 1}, 1}()\nllhs = Array{Array{Float64, 1}, 1}()\nmses = Array{Float64, 1}()\n\n# propagate the TLE for 10 days in 1/2 day increments\nfor ds50UTC in starttime:0.5:(starttime + 10)\n    pos, vel, llh, mse = SAASGP4.sgp4PropDs50UTC(satkey, ds50UTC)\n    push!(poss, pos)\n    push!(vels, vel)\n    push!(llhs, llh)\n    push!(mses, mse)\nend\n\n# remove the TLE from memory\nSAASGP4.sgp4RemoveSat(satkey)\nSAASGP4.tleRemoveSat(satkey)"
},

{
    "location": "lib.html#",
    "page": "Public",
    "title": "Public",
    "category": "page",
    "text": ""
},

{
    "location": "lib.html#Library-1",
    "page": "Public",
    "title": "Library",
    "category": "section",
    "text": ""
},

{
    "location": "lib.html#Contents-1",
    "page": "Public",
    "title": "Contents",
    "category": "section",
    "text": ""
},

{
    "location": "lib.html#Index-1",
    "page": "Public",
    "title": "Index",
    "category": "section",
    "text": ""
},

{
    "location": "lib.html#SAASGP4.DTGToUTC-Tuple{Any}",
    "page": "Public",
    "title": "SAASGP4.DTGToUTC",
    "category": "method",
    "text": "DTGToUTC(dtg)\n\nConverts a time in one of the DTG formats to a time in ds50UTC. DTG15, DTG17, DTG19, and DTG20 formats are accepted\n\n\n\n"
},

{
    "location": "lib.html#SAASGP4.astroFuncInit-Tuple{Any}",
    "page": "Public",
    "title": "SAASGP4.astroFuncInit",
    "category": "method",
    "text": "astroFuncInit(mainHandle)\n\nInitializes AstroFunc DLL for use in the program\n\n\n\n"
},

{
    "location": "lib.html#SAASGP4.closeLogFile-Tuple{}",
    "page": "Public",
    "title": "SAASGP4.closeLogFile",
    "category": "method",
    "text": "closeLogFile()\n\nCloses the currently open log file\n\n\n\n"
},

{
    "location": "lib.html#SAASGP4.envGetFkConst-Tuple{Any}",
    "page": "Public",
    "title": "SAASGP4.envGetFkConst",
    "category": "method",
    "text": "envGetFkConst(id)\n\nRetrieves the value of one of the constants from the current fundamental catalogue (FK) model\n\n\n\n"
},

{
    "location": "lib.html#SAASGP4.envGetFkIdx-Tuple{}",
    "page": "Public",
    "title": "SAASGP4.envGetFkIdx",
    "category": "method",
    "text": "Returns the current fundamental catalogue (FK) setting\n\n\n\n"
},

{
    "location": "lib.html#SAASGP4.envGetFkPtr-Tuple{}",
    "page": "Public",
    "title": "SAASGP4.envGetFkPtr",
    "category": "method",
    "text": "envGetFkPtr()\n\nReturns a handle that can be used to access the fundamental catalogue (FK) data structure\n\n\n\n"
},

{
    "location": "lib.html#SAASGP4.envGetGeoConst-Tuple{Any}",
    "page": "Public",
    "title": "SAASGP4.envGetGeoConst",
    "category": "method",
    "text": "envGetGeoConst(id)\n\nRetrieves the value of one of the constants from the current Earth constants (GEO) model\n\n\n\n"
},

{
    "location": "lib.html#SAASGP4.envGetGeoIdx-Tuple{}",
    "page": "Public",
    "title": "SAASGP4.envGetGeoIdx",
    "category": "method",
    "text": "Returns the current Earth constants (GEO) setting\n\n\n\n"
},

{
    "location": "lib.html#SAASGP4.envGetGeoStr-Tuple{}",
    "page": "Public",
    "title": "SAASGP4.envGetGeoStr",
    "category": "method",
    "text": "envGetGeoStr()\n\nReturns the name of the current Earth constants (GEO) model\n\n\n\n"
},

{
    "location": "lib.html#SAASGP4.envGetInfo-Tuple{}",
    "page": "Public",
    "title": "SAASGP4.envGetInfo",
    "category": "method",
    "text": "envGetInfo()\n\nReturns information about the EnvConst DLL\n\n\n\n"
},

{
    "location": "lib.html#SAASGP4.envInit-Tuple{Int64}",
    "page": "Public",
    "title": "SAASGP4.envInit",
    "category": "method",
    "text": "envInit(mainHandle::Clonglong)\n\nInitializes the EnvInit DLL for use in the program\n\n\n\n"
},

{
    "location": "lib.html#SAASGP4.envLoadFile-Tuple{Any}",
    "page": "Public",
    "title": "SAASGP4.envLoadFile",
    "category": "method",
    "text": "envLoadFile(path)\n\nReads Earth constants (GEO) model and fundamental catalogue (FK) model settings from a file\n\n\n\n"
},

{
    "location": "lib.html#SAASGP4.envSaveFile",
    "page": "Public",
    "title": "SAASGP4.envSaveFile",
    "category": "function",
    "text": "envSaveFile(path, append = 0, format = 0)\n\nSaves the current Earth constants (GEO) model and fundamental catalogue (FK) model settings to a file\n\n\n\n"
},

{
    "location": "lib.html#SAASGP4.envSetFkIdx-Tuple{Any}",
    "page": "Public",
    "title": "SAASGP4.envSetFkIdx",
    "category": "method",
    "text": "envSetFkIdx(id)\n\nChanges the fundamental catalogue (FK) setting to the specified value\n\n\n\n"
},

{
    "location": "lib.html#SAASGP4.envSetGeoIdx-Tuple{Any}",
    "page": "Public",
    "title": "SAASGP4.envSetGeoIdx",
    "category": "method",
    "text": "envSetGeoIdx(id)\n\nChanges the Earth constants (GEO) setting to the specified value\n\n\n\n"
},

{
    "location": "lib.html#SAASGP4.envSetGeoStr-Tuple{Any}",
    "page": "Public",
    "title": "SAASGP4.envSetGeoStr",
    "category": "method",
    "text": "envSetGeoStr(geoStr)\n\nChanges the Earth constants (GEO) setting to the model specified by a string literal\n\n\n\n"
},

{
    "location": "lib.html#SAASGP4.getInitDllNames-Tuple{}",
    "page": "Public",
    "title": "SAASGP4.getInitDllNames",
    "category": "method",
    "text": "getInitDllNames()\n\nReturns a list of names of the Standardized Astrodynamic Algorithms DLLs that were initialized successfully\n\n\n\n"
},

{
    "location": "lib.html#SAASGP4.getLastErrMsg-Tuple{}",
    "page": "Public",
    "title": "SAASGP4.getLastErrMsg",
    "category": "method",
    "text": "getLastErrMsg()\n\nReturns a character string describing the last error that occurred\n\n\n\n"
},

{
    "location": "lib.html#SAASGP4.getLastInfoMsg-Tuple{}",
    "page": "Public",
    "title": "SAASGP4.getLastInfoMsg",
    "category": "method",
    "text": "getLastInfoMsg()\n\nReturns a character string describing the last informational message that was recorded\n\n\n\n"
},

{
    "location": "lib.html#SAASGP4.mainGetInfo-Tuple{}",
    "page": "Public",
    "title": "SAASGP4.mainGetInfo",
    "category": "method",
    "text": "mainGetInfo()\n\nReturns information about the DllMain DLL\n\n\n\n"
},

{
    "location": "lib.html#SAASGP4.mainInit-Tuple{}",
    "page": "Public",
    "title": "SAASGP4.mainInit",
    "category": "method",
    "text": "mainInit()\n\nReturns a handle which can be used to access the static global data set needed by the Standardized Astrodynamic Algorithms DLLs to communicate among themselves\n\n\n\n"
},

{
    "location": "lib.html#SAASGP4.openLogFile-Tuple{Any}",
    "page": "Public",
    "title": "SAASGP4.openLogFile",
    "category": "method",
    "text": "openLogFile(path)\n\nOpens a log file and enables the writing of diagnostic information into it\n\n\n\n"
},

{
    "location": "lib.html#SAASGP4.sgp4Init-Tuple{Any}",
    "page": "Public",
    "title": "SAASGP4.sgp4Init",
    "category": "method",
    "text": "sgp4Init(mainHandle)\n\nInitializes the Sgp4 DLL for use in the program\n\n\n\n"
},

{
    "location": "lib.html#SAASGP4.sgp4InitSat-Tuple{Any}",
    "page": "Public",
    "title": "SAASGP4.sgp4InitSat",
    "category": "method",
    "text": "sgp4InitSat(satkey)\n\nInitializes an SGP4 satellite from an SGP or SGP4 TLE\n\n\n\n"
},

{
    "location": "lib.html#SAASGP4.sgp4PropDs50UTC!-NTuple{6,Any}",
    "page": "Public",
    "title": "SAASGP4.sgp4PropDs50UTC!",
    "category": "method",
    "text": "sgp4PropDs50UTC!(satkey, ds50UTC, pos, vel, llh, mse)\n\nPropagates a satellite, represented by the satKey, to the time expressed in days since 1950, UTC\n\n\n\n"
},

{
    "location": "lib.html#SAASGP4.sgp4PropDs50UTC-Tuple{Any,Any}",
    "page": "Public",
    "title": "SAASGP4.sgp4PropDs50UTC",
    "category": "method",
    "text": "sgp4PropDs50UTC(satkey, ds50UTC)\n\nPropagates a satellite, represented by the satKey, to the time expressed in days since 1950, UTC\n\n\n\n"
},

{
    "location": "lib.html#SAASGP4.sgp4PropMse!-NTuple{6,Any}",
    "page": "Public",
    "title": "SAASGP4.sgp4PropMse!",
    "category": "method",
    "text": "sgp4PropMse!(satkey, mse, pos, vel, llh, ds50UTC)\n\nPropagates a satellite, represented by the satKey, to the time expressed in minutes since the satellite\'s epoch time. Stores the results in the provided variables.\n\nExamples\n\njulia> pos = Array{Cdouble, 1}(undef, 3)\n3-element Array{Float64,1}:\n 0.0\n 0.0\n 0.0\n\njulia> vel = Array{Cdouble, 1}(undef, 3)\n3-element Array{Float64,1}:\n 0.0\n 0.0\n 0.0\n\njulia> llh = Array{Cdouble, 1}(undef, 3)\n3-element Array{Float64,1}:\n 0.0\n 0.0\n 0.0\n\njulia> ds50UTC = Ref{Cdouble}(0.0)\nBase.RefValue{Float64}(0.0)\n\njulia> SAASGP4.sgp4PropMse!(satkey, mse, pos, vel, llh, ds50UTC)\n\njulia> pos\n3-element Array{Float64,1}:\n 42155.0257401623\n   980.5342672211367\n    -9.307135121360039\n\njulia> vel\n3-element Array{Float64,1}:\n -0.07133558166329691\n  3.07373221015029\n -0.0018402927526264539\n\njulia> llh\n3-element Array{Float64,1}:\n    -0.012659361941212956\n    34.46169610621692\n 35788.29393717118\n\njulia> ds50UTC[]\n18314.489312984446\n\n\n\n"
},

{
    "location": "lib.html#SAASGP4.sgp4PropMse-Tuple{Any,Any}",
    "page": "Public",
    "title": "SAASGP4.sgp4PropMse",
    "category": "method",
    "text": "sgp4PropMse(satkey, mse)\n\nPropagates a satellite, represented by the satKey, to the time expressed in minutes since the satellite\'s epoch time\n\n\n\n"
},

{
    "location": "lib.html#SAASGP4.sgp4RemoveAllSats-Tuple{Any}",
    "page": "Public",
    "title": "SAASGP4.sgp4RemoveAllSats",
    "category": "method",
    "text": "sgp4RemoveAllSats(satkey)\n\nRemoves all currently loaded satellites from memory\n\n\n\n"
},

{
    "location": "lib.html#SAASGP4.sgp4RemoveSat-Tuple{Any}",
    "page": "Public",
    "title": "SAASGP4.sgp4RemoveSat",
    "category": "method",
    "text": "sgp4RemoveSat(satkey)\n\nRemoves a satellite, represented by the satKey, from the set of satellites\n\n\n\n"
},

{
    "location": "lib.html#SAASGP4.sgp4SetLicFilePath-Tuple{Any}",
    "page": "Public",
    "title": "SAASGP4.sgp4SetLicFilePath",
    "category": "method",
    "text": "sgp4SetLicFilePath(licFilePath)\n\nInitializes the Sgp4 DLL for use in the program\n\n\n\n"
},

{
    "location": "lib.html#SAASGP4.timeFuncInit-Tuple{Any}",
    "page": "Public",
    "title": "SAASGP4.timeFuncInit",
    "category": "method",
    "text": "timeFuncInit(mainHandle)\n\nInitializes the TimeFunc DLL for use in the program\n\n\n\n"
},

{
    "location": "lib.html#SAASGP4.tleAddSatFrLines-Tuple{Any,Any}",
    "page": "Public",
    "title": "SAASGP4.tleAddSatFrLines",
    "category": "method",
    "text": "tleAddSatFrLines(line1, line2)\n\nAdds a TLE (satellite), using its directly specified first and second lines\n\n\n\n"
},

{
    "location": "lib.html#SAASGP4.tleInit-Tuple{Any}",
    "page": "Public",
    "title": "SAASGP4.tleInit",
    "category": "method",
    "text": "tleInit(mainHandle)\n\nInitializes Tle DLL for use in the program\n\n\n\n"
},

{
    "location": "lib.html#SAASGP4.tleRemoveAllSats-Tuple{}",
    "page": "Public",
    "title": "SAASGP4.tleRemoveAllSats",
    "category": "method",
    "text": "tleRemoveAllSats()\n\nRemoves all the TLEs from memory\n\n\n\n"
},

{
    "location": "lib.html#SAASGP4.tleRemoveSat-Tuple{Any}",
    "page": "Public",
    "title": "SAASGP4.tleRemoveSat",
    "category": "method",
    "text": "tleRemoveSat(satkey)\n\nRemoves a TLE represented by the satKey from memory\n\n\n\n"
},

{
    "location": "lib.html#Interface-1",
    "page": "Public",
    "title": "Interface",
    "category": "section",
    "text": "Modules = [SAASGP4]"
},

]}
