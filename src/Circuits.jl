

abstract type AbstractCircuit end

struct BaseCircuit <: AbstractCircuit

		values::Vector{Any}
		elements::Vector{String}

end

function getImp(circuit::BaseCircuit)
	a = []
	for i in circuit.values
		if typeof(i) == L || typeof(i) == R || typeof(i) == C || typeof(i) == CPE
			push!(a,calcImp(i))
		else
			b = []
			for j in i
				push!(b,calcImp(j))
			end
			push!(a,b)
		end
	end
	return a
end

function getFreq(circuit::BaseCircuit)
	a = []
	for i in circuit.values
		if typeof(i) == L || typeof(i) == R || typeof(i) == C || typeof(i) == CPE
			push!(a,i.f)
		else
			b = []
			for j in i
				push!(b,j.f)
			end
			push!(a,b)
		end
	end
	return a
end

function getElem(circuit::BaseCircuit)
		return circuit.elements
end

function calculateCircuitLength(circuit::BaseCircuit)
	lengthCircuit = 0
	for i in getImp(circuit)
		lengthCircuit += length(i)
	end
	return lengthCircuit
end

function ImpedanceCircuit(circuit::BaseCircuit)
	Zall = 0
	for i in getImp(circuit)
		if length(i) == 1
			Zall += i
		else
			Zall += p(i)
		end
	end
	return Zall
end

function modZ(Z::Complex)
	return sqrt(real(Z)^2+imag(Z)^2)
end

function argZ(Z::Complex)
	return atan(imag(Z),real(Z))*(180/pi)
end

begin
	function RangeFreq(circuit::BaseCircuit, fStart::Int64, fEnd::Int64, nbEva::Int)

		x = range(start = fStart, step = (fEnd-fStart)/nbEva, stop = fEnd)
		a = []

		for k in x
			for i in circuit.values
				if typeof(i) == L || typeof(i) == R || typeof(i) == C || typeof(i) == CPE
					i.f = k
				else
					for j in i
						j.f = k
					end
				end
			end
			temp = ImpedanceCircuit(circuit)
			push!(a,[temp,k])
		end

		return a
	end

	function RangeFreq(circuit::BaseCircuit, freq::Vector{Int64})

		a = []

		for k in freq
			for i in circuit.values
				if typeof(i) == L || typeof(i) == R || typeof(i) == C || typeof(i) == CPE
					i.f = k
				else
					for j in i
						j.f = k
					end
				end
			end
			temp = ImpedanceCircuit(circuit)
			push!(a,[temp,k])
		end

		return a
	end
end
