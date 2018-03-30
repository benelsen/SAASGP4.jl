using SAASGP4

@static if VERSION < v"0.7.0-DEV.2005"
    using Base.Test
else
    using Test
end

# Placehold for some real tests:
@test SAASGP4.mainGetInfo() == "HQ AFSPC DllMain DLL - Version: V7.8 - Build: Jul 07 2017 - Platform: Linux 64-bit"
