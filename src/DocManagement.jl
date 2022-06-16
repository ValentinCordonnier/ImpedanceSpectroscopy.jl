

function saveData(data,nb)


	out= zeros(length(data),3)
	index = 1
	for i in data
		reals = real(i[1])
    	imags = imag(i[1])
		freq = i[2]
		out[index,:] = vcat(reals, imags, freq)
		index += 1
	end

    CSV.write("datasets\\MyData$nb.csv", Tables.table(out),delim=',',decimal='.', header=false)
end

function createAndSave(circuit::BaseCircuit, fStart::Int64, fEnd::Int64, nbEva::Int, nb)
	data = RangeFreq(circuit, fStart, fEnd, nbEva)

	saveData(data,nb)
end
