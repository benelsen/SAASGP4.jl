using SAASGP4, Compat

@static if VERSION < v"0.7.0-DEV.2005"
    using Base.Test
else
    using Test
end

tmpdir = mktempdir()

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
        @test_nowarn SAASGP4.openLogFile(joinpath(tmpdir, "log.txt"))
        @test isfile(joinpath(tmpdir, "log.txt"))
    end

    @testset "closeLogFile" begin
        @test_nowarn SAASGP4.closeLogFile()
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
        @testset "value: $value" for value in ["WGS-84", "EGM-96", "WGS-72", "JGM2", "SEM68R", "GEM5", "GEM9"]
            SAASGP4.envSetGeoStr(value)
            @test SAASGP4.envGetGeoStr() == value
        end

        # Reset to WGS-72
        SAASGP4.envSetGeoStr("WGS-72")
        @test SAASGP4.envGetGeoStr() == "WGS-72"

        # Set to invalid value is no-op
        SAASGP4.envSetGeoStr("WGS-52")
        @test SAASGP4.envGetGeoStr() == "WGS-72"
    end

    @testset "envGetGeoIdx" begin
        @test SAASGP4.envGetGeoIdx() isa Integer
        @test SAASGP4.envGetGeoIdx() == 72
    end

    @testset "envSetGeoIdx" begin
        @testset "id: $id" for id in [84, 96, 72, 2, 68, 5, 9]
            SAASGP4.envSetGeoIdx(id)
            @test SAASGP4.envGetGeoIdx() == id
        end

        # Reset to 72
        SAASGP4.envSetGeoIdx(72)
        @test SAASGP4.envGetGeoIdx() == 72

        # Set to invalid number is no-op
        SAASGP4.envSetGeoIdx(1)
        @test SAASGP4.envGetGeoIdx() == 72
    end

    @testset "envGetGeoConst id: $id" for id in 1:11
        @test SAASGP4.envGetGeoConst(id) isa AbstractFloat
    end

    @testset "envGetFkIdx" begin
        @test SAASGP4.envGetFkIdx() isa Integer
        @test SAASGP4.envGetFkIdx() == 5
    end

    @testset "envSetFkIdx" begin
        SAASGP4.envSetFkIdx(4)
        @test SAASGP4.envGetFkIdx() == 4

        # Set to invalid number is no-op
        SAASGP4.envSetFkIdx(8)
        @test SAASGP4.envGetFkIdx() == 4

        # Reset to 5
        SAASGP4.envSetFkIdx(5)
        @test SAASGP4.envGetFkIdx() == 5
    end

    @testset "envGetFkConst id: $id" for id in 1:11
        @test SAASGP4.envGetFkConst(id) isa AbstractFloat
    end

    @testset "envGetFkPtr" begin
        @test SAASGP4.envGetFkPtr() isa Integer
        # TODO: Check if usable in ThetaGrnwch
    end

    @testset "envSaveFile" begin
        path = joinpath(tmpdir, "envFile.txt")
        @test_nowarn SAASGP4.envSaveFile(path)
        @test isfile(path)

        # Give empty file path
        @test_throws ErrorException SAASGP4.envSaveFile("")

        # Give impossible file path
        @test_throws ErrorException SAASGP4.envSaveFile(joinpath(tmpdir, "bogus", "envFile.txt"))
    end

    @testset "envLoadFile" begin
        # Check for actuall op to env constants
        @test_nowarn SAASGP4.envLoadFile(joinpath(@__DIR__, "wgs84fk4.txt"))
        @test SAASGP4.envGetFkIdx() == 4
        @test SAASGP4.envGetGeoIdx() == 84

        # Reset constants and check for file saved in `envSaveFile`
        @test_nowarn SAASGP4.envLoadFile(joinpath(tmpdir, "envFile.txt"))
        @test SAASGP4.envGetFkIdx() == 5
        @test SAASGP4.envGetGeoIdx() == 72

        # Give non-existant file path
        @test_throws ErrorException SAASGP4.envLoadFile(joinpath(tmpdir, "bogus.txt"))
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

        @test_throws ErrorException SAASGP4.tleRemoveSat(42)
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
        @test_nowarn SAASGP4.sgp4SetLicFilePath(normpath(joinpath(@__DIR__, "../deps/usr/lib/")))
        # TODO: Test for op. This only affects the library if it's called before `sgp4Init`.
        #       But as the path is set during `__init__`, it is effectivly tested before this point.
    end

    line1 = "1 90021U RELEAS14 00051.47568104 +.00000184 +00000+0 +00000-4 0 0814"
    line2 = "2 90021   0.0222 182.4923 0000720  45.6036 131.8822  1.00271328 1199"
    satkey = SAASGP4.tleAddSatFrLines(line1, line2)

    @testset "sgp4InitSat" begin
        @test_nowarn SAASGP4.sgp4InitSat(satkey)
        # TODO: Check if `satkey` can actually be used to propagate

        @test_throws ErrorException SAASGP4.sgp4InitSat(42)
    end

    @testset "sgp4RemoveSat" begin
        @test_nowarn SAASGP4.sgp4RemoveSat(satkey)
        # TODO: Check if `satkey` is actually removed

        @test_throws ErrorException SAASGP4.sgp4RemoveSat(42)
    end

    @testset "sgp4RemoveAllSats" begin
        SAASGP4.sgp4InitSat(satkey)
        @test_nowarn SAASGP4.sgp4RemoveAllSats()
        # TODO: Check if all sats are actually removed
    end

    SAASGP4.sgp4InitSat(satkey)

    @testset "sgp4PropDs50UTC" begin
        @testset begin
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

        @test_throws ErrorException SAASGP4.sgp4PropDs50UTC(42, 12345.678)
    end

    @testset "sgp4PropDs50UTC!" begin
        @testset begin
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

        @testset begin
            pos = Array{Cdouble, 1}(undef, 3)
            vel = Array{Cdouble, 1}(undef, 3)
            llh = Array{Cdouble, 1}(undef, 3)
            mse = Ref{Cdouble}(0.0)
            @test_throws ErrorException SAASGP4.sgp4PropDs50UTC!(pos, vel, llh, mse, 42, 12345.678)
        end
    end

    @testset "sgp4PropMse" begin
        @testset begin
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

        @test_throws ErrorException SAASGP4.sgp4PropMse(42, 123.4567)
    end

    @testset "sgp4PropMse!" begin
        @testset begin
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

        @testset begin
            pos = Array{Cdouble, 1}(undef, 3)
            vel = Array{Cdouble, 1}(undef, 3)
            llh = Array{Cdouble, 1}(undef, 3)
            ds50UTC = Ref{Cdouble}(0.0)
            @test_throws ErrorException SAASGP4.sgp4PropMse!(pos, vel, llh, ds50UTC, 42, 123.4567)
        end
    end

    @testset "sgp4GetPropOut" begin
        tle1line1 = "1 90001U SGP4-VAL 93051.47568104 +.00000184  00000 0  00000-4 0 0814"
        tle1line2 = "2 90001   0.0221 182.4922 0000720  45.6036 131.8822  1.0027132801199"

        satkey1 = SAASGP4.tleAddSatFrLines(tle1line1, tle1line2)
        SAASGP4.sgp4InitSat(satkey1)

        @test_throws ErrorException SAASGP4.sgp4GetPropOut(satkey1, 0)

        SAASGP4.sgp4PropMse(satkey1, 1.0)

        data = SAASGP4.sgp4GetPropOut(satkey1, 1)
        @test data isa Array{T, 1} where T <: AbstractFloat
        @test length(data) === 1

        data = SAASGP4.sgp4GetPropOut(satkey1, 2)
        @test data isa Array{T, 1} where T <: AbstractFloat
        @test length(data) === 3

        data = SAASGP4.sgp4GetPropOut(satkey1, 3)
        @test data isa Array{T, 1} where T <: AbstractFloat
        @test length(data) === 6

        data = SAASGP4.sgp4GetPropOut(satkey1, 4)
        @test data isa Array{T, 1} where T <: AbstractFloat
        @test length(data) === 6

        @test_throws ErrorException SAASGP4.sgp4GetPropOut(satkey1, 0)
        @test_throws ErrorException SAASGP4.sgp4GetPropOut(satkey1, 5)

        # TODO: check values against references?
    end
end

rm(tmpdir, recursive = true)
