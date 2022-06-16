
begin

	function plotNyquist(data)
		plot(real(data), imag(data), framestyle = :origin, xlabel = "Z/Ω", ylabel = "-Z/Ω", xlim = [0,100], ylim = [-50,0], label = "circuit1", yflip = true, seriestype = :scatter, title = "Nyquist Plot")
	end

	function plotNyquist(dataset::String, xlim::Int64, ylim::Int64)
		df = CSV.read(dataset, DataFrame, header = 0)
		real1 = df[!,1]
		imag1 = df[!,2]
		freq = df[!,3]

		plot(real1, imag1, framestyle = :origin, xlabel = "Z/Ω", ylabel = "-Z/Ω", xlim = [0,xlim], ylim = [-ylim,0], label = "circuit1", yflip = true, seriestype = :scatter, title = "Nyquist Plot")
	end

end

begin

	function plotBode(data::Vector{Any}, xlim::Int64, ylim::Int64)

		modImp = []
		argImp = []

		for i in data
			push!(modImp,20*log10(modZ(i[1])))
			push!(argImp,(argZ(i[1])))
		end


		logFreq = []
		for i in freq
			push!(logFreq,20*log10(i[2]))
		end

		p1 = plot(logFreq, modImp, framestyle = :origin, xlabel = "Frequency (Hz)", ylabel = "|Z|", xlim = [0,xlim], ylim = [0, ylim], label = "circuit1", yflip = false, seriestype = :line, title = "Bode Plot", lw = 3)

		p2 = plot(logFreq, argImp, framestyle = :origin, xlabel = "Frequency (Hz)", ylabel = "Phase", xlim = [0,xlim], ylim = [-90,0], label = "circuit1", yflip = false, seriestype = :line, title = "Bode Plot", lw = 3)

		plot(p1, p2, layout = (2, 1), legend = false)
	end

	function plotBode(dataset::String, xlim::Int64, ylim::Int64)

		df = CSV.read(dataset, DataFrame, header = 0)
		real1 = df[!,1]
		imag1 = df[!,2]
		freq = df[!,3]

		imp = real1+j*imag1
		modImp = []
		for i in imp
			push!(modImp,20*log10(modZ(i)))
		end

		argImp = []
		for i in imp
			push!(argImp,(argZ(i)))
		end

		logFreq = []
		for i in freq
			push!(logFreq,20*log10(i))
		end

		p1 = plot(logFreq, modImp, framestyle = :origin, xlabel = "Frequency (Hz)", ylabel = "|Z|", xlim = [0,xlim], ylim = [0, ylim], label = "circuit1", yflip = false, seriestype = :line, title = "Bode Plot", lw = 3)

		p2 = plot(logFreq, argImp, framestyle = :origin, xlabel = "Frequency (Hz)", ylabel = "Phase", xlim = [0,xlim], ylim = [-90,0], label = "circuit1", yflip = false, seriestype = :line, title = "Bode Plot", lw = 3)

		plot(p1, p2, layout = (2, 1), legend = false)
	end

end
