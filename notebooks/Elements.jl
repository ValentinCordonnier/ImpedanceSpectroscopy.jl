### A Pluto.jl notebook ###
# v0.19.5

using Markdown
using InteractiveUtils

# ╔═╡ 1de03b56-8f03-4e9a-9d8d-2e5f04c8e741
md""" ## I. Definitions
"""

# ╔═╡ 4d45c3e8-17a3-4e73-89c0-dc289ce2be1e
j = 1.0im

# ╔═╡ 00dd803f-e561-4063-aab1-f28221694dde
md""" Adds elements in series
	
     """

# ╔═╡ d6f2fa6a-d276-41fa-a2da-2d322bcb6177
function s(series)
	
	z = 0
    for elem in series
        z += elem[1]
	end
    return z
end

# ╔═╡ 30e0f5a0-205d-40d3-8bb1-ebcc4a1558a3
md""" Adds elements in parallel
	
     """

# ╔═╡ 46a541c7-a8fe-4a7c-aec7-ea98d2b121a3
abstract type AbstractElem end

# ╔═╡ 63a27358-47d5-4c64-b999-44b068aeb3f0
md""" Defines an inductor

	Z = L × j2πf

     """

# ╔═╡ 47bade36-8484-431d-90ae-27ad226f68bc
mutable struct L <: AbstractElem
	p::Float64
	f::Float64
end

# ╔═╡ 149d27b1-21a6-44a3-8bab-07bc382667f7
md""" Defines a resistor

        Z = R

    """

# ╔═╡ ce9791fc-2635-4e8e-b25d-2e88dd454e67
mutable struct R <: AbstractElem
	p::Float64
	f::Float64
end

# ╔═╡ 01a1baa2-6410-49df-a145-63caadf01b21
md""" Defines a capacitor

	Z = 1 / (C×j2πf)

     """

# ╔═╡ 8062deb9-e5d6-4e46-bd87-51e1305971a8
mutable struct C <: AbstractElem
	p::Float64
	f::Float64
end

# ╔═╡ 79453f53-9f05-484e-a29a-f96b179a37b1
md""" Defines a constant phase element

	Z = 1 / (Q×(j2πf)^α)
   
    """

# ╔═╡ 95009c20-d3af-4002-bf75-011f51257de2
mutable struct CPE <: AbstractElem
	p::Vector{Float64}
	f::Float64
end

# ╔═╡ 9665eb9a-71da-4535-ae46-bbbcda2efa1c
begin
	calcOmega(elem::L) = elem.f*2*pi
	calcOmega(elem::R) = elem.f*2*pi
	calcOmega(elem::C) = elem.f*2*pi
	calcOmega(elem::CPE) = elem.f*2*pi
end

# ╔═╡ ed3e49eb-480e-4b7c-a940-f3f1ac272b52
begin
	calcImp(elem::L) = elem.p[1]*1j*calcOmega(elem)
	calcImp(elem::R) = elem.p[1]*length(elem.f)
	calcImp(elem::C) = 1/(elem.p[1]*1j*calcOmega(elem))
	calcImp(elem::CPE) = 1.0/(elem.p[1]*(j*calcOmega(elem))^elem.p[2])
end

# ╔═╡ 59f5dbe6-17bd-4b63-b0c1-a7d21ebb3ad6
begin
	function p(parallel)
		
	    z = 0
		if typeof(parallel[1]) == L || typeof(parallel[1]) == R || typeof(parallel[1]) == C || typeof(parallel[1]) == CPE
			
		    for elem in parallel
		        z += 1/calcImp(elem)
			end
		else
			for elem in parallel
		        z += 1/elem
			end
		end
	    return 1/z
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
# ╟─1de03b56-8f03-4e9a-9d8d-2e5f04c8e741
# ╠═4d45c3e8-17a3-4e73-89c0-dc289ce2be1e
# ╟─00dd803f-e561-4063-aab1-f28221694dde
# ╠═d6f2fa6a-d276-41fa-a2da-2d322bcb6177
# ╟─30e0f5a0-205d-40d3-8bb1-ebcc4a1558a3
# ╠═59f5dbe6-17bd-4b63-b0c1-a7d21ebb3ad6
# ╠═46a541c7-a8fe-4a7c-aec7-ea98d2b121a3
# ╟─63a27358-47d5-4c64-b999-44b068aeb3f0
# ╠═47bade36-8484-431d-90ae-27ad226f68bc
# ╟─149d27b1-21a6-44a3-8bab-07bc382667f7
# ╠═ce9791fc-2635-4e8e-b25d-2e88dd454e67
# ╟─01a1baa2-6410-49df-a145-63caadf01b21
# ╠═8062deb9-e5d6-4e46-bd87-51e1305971a8
# ╟─79453f53-9f05-484e-a29a-f96b179a37b1
# ╠═95009c20-d3af-4002-bf75-011f51257de2
# ╠═9665eb9a-71da-4535-ae46-bbbcda2efa1c
# ╠═ed3e49eb-480e-4b7c-a940-f3f1ac272b52
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
