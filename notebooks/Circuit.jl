### A Pluto.jl notebook ###
# v0.19.5

using Markdown
using InteractiveUtils

# ╔═╡ 3395eeb0-cfaf-4b82-9446-22e28ed7e87c
abstract type AbstractCircuit end

# ╔═╡ 5b8f1070-dffc-4122-88bb-b0a4ee9d838d
struct BaseCircuit <: AbstractCircuit
		
		values::Vector{Any}
		elements::Vector{String}

end

# ╔═╡ 137c365e-f85a-410c-bece-97d6edee2147
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

# ╔═╡ eeaa7409-f03f-4cbb-8e65-bf42fdbffd63
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

# ╔═╡ 938f7095-cb7d-4854-9a09-831d8adf9b12
function getElem(circuit::BaseCircuit)
		return circuit.elements
end

# ╔═╡ 53ac178d-5a1a-4a99-bb75-09965dec169e
function calculateCircuitLength(circuit::BaseCircuit)
	lengthCircuit = 0
	for i in getImp(circuit)
		lengthCircuit += length(i)
	end	
	return lengthCircuit
end

# ╔═╡ 73d4cc32-e99a-42e8-8855-75ac032ca316
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

# ╔═╡ e200f602-a8ac-41d8-b952-6070d161c46b
function modZ(Z::Complex)
	return sqrt(real(Z)^2+imag(Z)^2)
end

# ╔═╡ 01175de8-f23f-47b0-8858-472a1123fbf6
function argZ(Z::Complex)
	return atan(imag(Z),real(Z))*(180/pi)
end

# ╔═╡ 79d9b166-8c4e-41a4-917d-32420c3a2234
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

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.7.2"
manifest_format = "2.0"

[deps]
"""

# ╔═╡ Cell order:
# ╠═3395eeb0-cfaf-4b82-9446-22e28ed7e87c
# ╠═5b8f1070-dffc-4122-88bb-b0a4ee9d838d
# ╠═137c365e-f85a-410c-bece-97d6edee2147
# ╠═eeaa7409-f03f-4cbb-8e65-bf42fdbffd63
# ╠═938f7095-cb7d-4854-9a09-831d8adf9b12
# ╠═53ac178d-5a1a-4a99-bb75-09965dec169e
# ╠═73d4cc32-e99a-42e8-8855-75ac032ca316
# ╠═e200f602-a8ac-41d8-b952-6070d161c46b
# ╠═01175de8-f23f-47b0-8858-472a1123fbf6
# ╠═79d9b166-8c4e-41a4-917d-32420c3a2234
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
