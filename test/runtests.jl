using ImpedanceSpectroscopy
using Test

@testset "ImpedanceSpectroscopy.jl" begin

    R1 = R(10,1000)
	C2 = C(0.000006,1000)
	L3 = L(0.00005,1000)
	CPE1 = CPE([0.00005,3],1000)

	circuit1 = BaseCircuit([R1,C2,L3],["R1-C2-L3"])
	circuit2 = BaseCircuit([R1,C2,[R1,C2,R1],L3],["R1-C2-[R1-C2-R1]-L3"])


	@test ImpedanceCircuit(circuit1) == 10.0 - 26.211664583290244im
	@test ImpedanceCircuit(circuit2) == 14.828442652140108 - 27.121804581144822im
end
