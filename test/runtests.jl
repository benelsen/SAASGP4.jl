using SAASGP4

@static if VERSION < v"0.7.0-DEV.2005"
    using Base.Test
else
    using Test
end

@testset "DllMain" begin
    @testset "getLastErrMsg" begin
        @test SAASGP4.getLastErrMsg() isa AbstractString
        @test SAASGP4.getLastErrMsg() == ""
    end

    @testset "getLastInfoMsg" begin
        @test SAASGP4.getLastInfoMsg() isa AbstractString
        @test SAASGP4.getLastInfoMsg() == ""
    end

    @testset "mainGetInfo" begin
        @test SAASGP4.mainGetInfo() isa AbstractString
        @test length(SAASGP4.mainGetInfo()) > 0
    end

    @testset "getInitDllNames" begin
        @test SAASGP4.getInitDllNames() isa AbstractString
        @test SAASGP4.getInitDllNames() == "Initialized Dlls: DllMain,TimeFunc,EnvConst,AstroFunc,Tle,Sgp4Prop,"
    end

    @testset "openLogFile" begin
        @test_broken SAASGP4.openLogFile(path)
    end

    @testset "closeLogFile" begin
        @test_broken SAASGP4.closeLogFile()
    end
end

@testset "EnvConst" begin
    @testset "envGetInfo" begin
        @test SAASGP4.envGetInfo() isa AbstractString
        @test length(SAASGP4.envGetInfo()) > 0
    end

    @testset "envGetGeoStr" begin
        @test SAASGP4.envGetGeoStr() isa AbstractString
        @test SAASGP4.envGetGeoStr() == "WGS-72"
    end

    @testset "envSetGeoStr" begin
        @test_broken SAASGP4.envSetGeoStr(geoStr)
    end

    @testset "envGetGeoIdx" begin
        @test SAASGP4.envGetGeoIdx() isa Integer
        @test SAASGP4.envGetGeoIdx() == 72
    end

    @testset "envSetGeoIdx" begin
        @test_broken SAASGP4.envSetGeoIdx(id)
    end

    @testset "envGetGeoConst" for id in 1:11
        @test SAASGP4.envGetGeoConst(id) isa AbstractFloat
    end

    @testset "envGetFkIdx" begin
        @test SAASGP4.envGetFkIdx() isa Integer
        @test SAASGP4.envGetFkIdx() == 5
    end

    @testset "envSetFkIdx" begin
        @test_broken SAASGP4.envSetFkIdx(id)
    end

    @testset "envGetFkConst" for id in 1:11
        @test SAASGP4.envGetFkConst(id) isa AbstractFloat
    end

    @testset "envGetFkPtr" begin
        @test_broken SAASGP4.envGetFkPtr()
    end

    @testset "envLoadFile" begin
        @test_broken SAASGP4.envLoadFile(path)
    end

    @testset "envSaveFile" begin
        @test_broken SAASGP4.envSaveFile(path, append = 0, format = 0)
    end
end

@testset "AstroFunc" begin
    @testset "astroFuncGetInfo" begin
        @test SAASGP4.astroFuncGetInfo() isa AbstractString
        @test length(SAASGP4.astroFuncGetInfo()) > 0
    end
end

@testset "TimeFunc" begin
    @testset "timeFuncGetInfo" begin
        @test SAASGP4.timeFuncGetInfo() isa AbstractString
        @test length(SAASGP4.timeFuncGetInfo()) > 0
    end

    @testset "DTGToUTC" begin
        dtg = "00051.47568104"
        ds50UTC = 18313.47568104
        @test SAASGP4.DTGToUTC(dtg) isa AbstractFloat
        @test SAASGP4.DTGToUTC(dtg) == ds50UTC
    end
end

@testset "Tle" begin
    @testset "tleGetInfo" begin
        @test SAASGP4.tleGetInfo() isa AbstractString
        @test length(SAASGP4.tleGetInfo()) > 0
    end

    @testset "tleAddSatFrLines" begin
        @test_broken SAASGP4.tleAddSatFrLines(line1, line2)
    end

    @testset "tleRemoveSat" begin
        @test_broken SAASGP4.tleRemoveSat(satkey)
    end

    @testset "tleRemoveAllSats" begin
        @test_broken SAASGP4.tleRemoveAllSats()
    end
end

@testset "Sgp4Prop" begin
    @testset "sgp4GetInfo" begin
        @test SAASGP4.sgp4GetInfo() isa AbstractString
        @test length(SAASGP4.sgp4GetInfo()) > 0
    end

    @testset "sgp4SetLicFilePath" begin
        @test_broken SAASGP4.sgp4SetLicFilePath(licFilePath)
    end

    @testset "sgp4InitSat" begin
        @test_broken SAASGP4.sgp4InitSat(satkey)
    end

    @testset "sgp4RemoveSat" begin
        @test_broken SAASGP4.sgp4RemoveSat(satkey)
    end

    @testset "sgp4RemoveAllSats" begin
        @test_broken SAASGP4.sgp4RemoveAllSats(satkey)
    end

    @testset "sgp4PropDs50UTC" begin
        @test_broken SAASGP4.sgp4PropDs50UTC(satkey, ds50UTC)
    end

    @testset "sgp4PropDs50UTC!" begin
        @test_broken SAASGP4.sgp4PropDs50UTC!(satkey, ds50UTC, pos, vel, llh, mse)
    end

    @testset "sgp4PropMse" begin
        @test_broken SAASGP4.sgp4PropMse(satkey, mse)
    end

    @testset "sgp4PropMse!" begin
        @test_broken SAASGP4.sgp4PropMse!(satkey, mse, pos, vel, llh, ds50UTC)
    end
end
