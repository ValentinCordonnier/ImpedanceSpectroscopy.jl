

abstract type AbstractCircuit end

struct BaseCircuit <: AbstractCircuit

		values::Vector{Any}
		elements::Vector{String}

end

"""
	getImp(circuit::BaseCircuit)

This function allows to obtain the impedance of a circuit (::BaseCircuit) from it


"""
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

"""
	getFreq(circuit::BaseCircuit)

This function allows to obtain the frequency of a circuit (::BaseCircuit) from it


"""
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

"""
	getElem(circuit::BaseCircuit)

This function allows to obtain the elements of a circuit (::BaseCircuit) from it


"""
function getElem(circuit::BaseCircuit)
		return circuit.elements
end
"""
	calculateCircuitLength(circuit::BaseCircuit)

This function allows to obtain the length of a circuit (::BaseCircuit) from it


"""
function calculateCircuitLength(circuit::BaseCircuit)
	lengthCircuit = 0
	for i in getImp(circuit)
		lengthCircuit += length(i)
	end
	return lengthCircuit
end

"""
	ImpedanceCircuit(circuit::BaseCircuit)

This function allows to obtain the total impedance of a circuit (::BaseCircuit) from it


"""
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

"""
	modZ(Z::Complex)

This function is used to get the module of a complex number (::Complex)


"""
function modZ(Z::Complex)
	return sqrt(real(Z)^2+imag(Z)^2)
end

"""
	argZ(Z::Complex)

This function is used to get the argument of a complex number (::Complex)


"""
function argZ(Z::Complex)
	return atan(imag(Z),real(Z))*(180/pi)
end

"""
	RangeFreq(circuit::BaseCircuit, fStart::Int64, fEnd::Int64, nbEva::Int)

	or RangeFreq(circuit::BaseCircuit, freq::Vector{Int64})

This function is used to get the impedance of a given circuit (::BaseCircuit) at some frequencies.
You can either give the starting frequency (::Int64) and the finishing one with the number of evaluation you want

or you can give a vector of chosen frequencies 


"""
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
