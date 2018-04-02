using SAASGP4, Compat

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
        @test_skip SAASGP4.openLogFile(path)
    end

    @testset "closeLogFile" begin
        @test_skip SAASGP4.closeLogFile()
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
        @test_skip SAASGP4.envSetGeoStr(geoStr)
    end

    @testset "envGetGeoIdx" begin
        @test SAASGP4.envGetGeoIdx() isa Integer
        @test SAASGP4.envGetGeoIdx() == 72
    end

    @testset "envSetGeoIdx" begin
        @test_skip SAASGP4.envSetGeoIdx(id)
    end

    @testset "envGetGeoConst" for id in 1:11
        @test SAASGP4.envGetGeoConst(id) isa AbstractFloat
    end

    @testset "envGetFkIdx" begin
        @test SAASGP4.envGetFkIdx() isa Integer
        @test SAASGP4.envGetFkIdx() == 5
    end

    @testset "envSetFkIdx" begin
        @test_skip SAASGP4.envSetFkIdx(id)
    end

    @testset "envGetFkConst" for id in 1:11
        @test SAASGP4.envGetFkConst(id) isa AbstractFloat
    end

    @testset "envGetFkPtr" begin
        @test_skip SAASGP4.envGetFkPtr()
    end

    @testset "envLoadFile" begin
        @test_skip SAASGP4.envLoadFile(path)
    end

    @testset "envSaveFile" begin
        @test_skip SAASGP4.envSaveFile(path, append = 0, format = 0)
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

    line1 = "1 90021U RELEAS14 00051.47568104 +.00000184 +00000+0 +00000-4 0 0814"
    line2 = "2 90021   0.0222 182.4923 0000720  45.6036 131.8822  1.00271328 1199"
    @testset "tleAddSatFrLines" begin
        satkey = SAASGP4.tleAddSatFrLines(line1, line2)
        @test satkey isa Integer
        SAASGP4.tleRemoveSat(satkey)
        # TODO: Check if `satkey` can actually be initialized, or if count is augmented
    end

    @testset "tleRemoveSat" begin
        satkey = SAASGP4.tleAddSatFrLines(line1, line2)
        @test_nowarn SAASGP4.tleRemoveSat(satkey)
        # TODO: Check if `satkey` is actually removed
    end

    @testset "tleRemoveAllSats" begin
        SAASGP4.tleAddSatFrLines(line1, line2)
        @test_nowarn SAASGP4.tleRemoveAllSats()
        # TODO: Check if all sats are actually removed
    end
end

@testset "Sgp4Prop" begin
    @testset "sgp4GetInfo" begin
        @test SAASGP4.sgp4GetInfo() isa AbstractString
        @test length(SAASGP4.sgp4GetInfo()) > 0
    end

    @testset "sgp4SetLicFilePath" begin
        @test_skip SAASGP4.sgp4SetLicFilePath(licFilePath)
    end

    line1 = "1 90021U RELEAS14 00051.47568104 +.00000184 +00000+0 +00000-4 0 0814"
    line2 = "2 90021   0.0222 182.4923 0000720  45.6036 131.8822  1.00271328 1199"
    satkey = SAASGP4.tleAddSatFrLines(line1, line2)

    @testset "sgp4InitSat" begin
        @test_nowarn SAASGP4.sgp4InitSat(satkey)
        # TODO: Check if `satkey` can actually be used to propagate
    end

    @testset "sgp4RemoveSat" begin
        @test_nowarn SAASGP4.sgp4RemoveSat(satkey)
        # TODO: Check if `satkey` is actually removed
    end

    @testset "sgp4RemoveAllSats" begin
        SAASGP4.sgp4InitSat(satkey)
        @test_nowarn SAASGP4.sgp4RemoveAllSats()
        # TODO: Check if all sats are actually removed
    end

    SAASGP4.sgp4InitSat(satkey)

    @testset "sgp4PropDs50UTC" begin
        ds50UTC = 18313.47568104 + 1.0 / 1440

        pos, vel, llh, mse = SAASGP4.sgp4PropDs50UTC(satkey, ds50UTC)

        @test pos isa Array{T, 1} where T <: AbstractFloat
        @test length(pos) === 3
        @test vel isa Array{T, 1} where T <: AbstractFloat
        @test length(vel) === 3
        @test llh isa Array{T, 1} where T <: AbstractFloat
        @test length(llh) === 3
        # TODO: check values against references?
        
        @test mse isa AbstractFloat
        @test mse ≈ 1.0
    end

    @testset "sgp4PropDs50UTC!" begin
        ds50UTC = 18313.47568104 + 1.0 / 1440

        pos = Array{Cdouble, 1}(undef, 3)
        vel = Array{Cdouble, 1}(undef, 3)
        llh = Array{Cdouble, 1}(undef, 3)
        mse = Ref{Cdouble}(0.0)

        SAASGP4.sgp4PropDs50UTC!(pos, vel, llh, mse, satkey, ds50UTC)

        @test pos isa Array{T, 1} where T <: AbstractFloat
        @test length(pos) === 3
        @test vel isa Array{T, 1} where T <: AbstractFloat
        @test length(vel) === 3
        @test llh isa Array{T, 1} where T <: AbstractFloat
        @test length(llh) === 3
        # TODO: check values against references?
        
        @test mse[] isa AbstractFloat
        @test mse[] ≈ 1.0
    end

    @testset "sgp4PropMse" begin
        mse = 1.0

        pos, vel, llh, ds50UTC = SAASGP4.sgp4PropMse(satkey, mse)

        @test pos isa Array{T, 1} where T <: AbstractFloat
        @test length(pos) === 3
        @test vel isa Array{T, 1} where T <: AbstractFloat
        @test length(vel) === 3
        @test llh isa Array{T, 1} where T <: AbstractFloat
        @test length(llh) === 3
        # TODO: check values against references?
        
        @test ds50UTC isa AbstractFloat
        @test ds50UTC ≈ 18313.47568104 + 1.0 / 1440
    end

    @testset "sgp4PropMse!" begin
        mse = 1.0

        pos = Array{Cdouble, 1}(undef, 3)
        vel = Array{Cdouble, 1}(undef, 3)
        llh = Array{Cdouble, 1}(undef, 3)
        ds50UTC = Ref{Cdouble}(0.0)

        SAASGP4.sgp4PropMse!(pos, vel, llh, ds50UTC, satkey, mse)

        @test pos isa Array{T, 1} where T <: AbstractFloat
        @test length(pos) === 3
        @test vel isa Array{T, 1} where T <: AbstractFloat
        @test length(vel) === 3
        @test llh isa Array{T, 1} where T <: AbstractFloat
        @test length(llh) === 3
        # TODO: check values against references?
        
        @test ds50UTC[] isa AbstractFloat
        @test ds50UTC[] ≈ 18313.47568104 + 1.0 / 1440
    end
end
