//This file was auto-corrected by findeclaration.exe on 25.5.2012 20:42:32

/proc/Intoxicated(phrase)
	phrase = html_decode(phrase)
	var/leng=length(phrase)
	var/counter=length(phrase)
	var/newphrase=""
	var/newletter=""
	while(counter>=1)
		newletter=copytext(phrase,(leng-counter)+1,(leng-counter)+2)
		if(rand(1,3)==3)
			if(lowertext(newletter)=="o")	newletter="u"
			if(lowertext(newletter)=="s")	newletter="ch"
			if(lowertext(newletter)=="a")	newletter="ah"
			if(lowertext(newletter)=="c")	newletter="k"
		switch(rand(1,7))
			if(1,3,5)	newletter="[lowertext(newletter)]"
			if(2,4,6)	newletter="[uppertext(newletter)]"
			if(7)	newletter+="'"
			//if(9,10)	newletter="<b>[newletter]</b>"
			//if(11,12)	newletter="<big>[newletter]</big>"
			//if(13)	newletter="<small>[newletter]</small>"
		newphrase+="[newletter]";counter-=1
	return newphrase

// This is prolonged effect, often toggled by prefences
/proc/stammer(phrase)
	phrase = html_decode(phrase)
	var/list/vowels = list(
		"а", "и", "о", "у", "ы", "э", "е", "ё", "ю", "я",
		"a", "e", "i", "o", "u"
		)
	var/list/consonants = list(
		"б", "в", "г", "д", "ж", "з", "й", "к", "л", "м", "н", "п", "р", "с", "т", "ф", "х", "ц", "ч", "ш", "щ",
		"b", "c", "d", "f", "g", "h", "j", "k", "l", "m", "n", "p", "q", "r", "s", "t", "v", "x", "z", "w", "y"
		)
	var/list/letters = vowels + consonants + "ь" + "ъ"
	var/stoppers = list(
		"б", "г", "д", "к", "п", "т", "ц", "ч",
		"b", "d", "g", "j", "k", "p", "t", "x"
		)
	var/new_phrase = ""
	var/index_in_word = 0
	var/last_char = ""
	for(var/i = 1, i <= length_char(phrase), i++)
		var/char = copytext_char(phrase, i, i + 1)
		var/current_char = lowertext(char)
		if(current_char in letters)
			index_in_word++
		else
			index_in_word = 0
		if(index_in_word == 2 && prob(40) && (last_char in consonants))
			var/passage = ""
			if(current_char in vowels)
				if((last_char in stoppers) && prob(50))
					passage = "-[last_char]"
				else
					passage = "[current_char]-[last_char]"
			else if(last_char in stoppers)
				passage = "-[last_char]"
			do
				new_phrase += passage
			while(prob(25))
		last_char = current_char
		new_phrase += char
	return html_encode(new_phrase)

/proc/Stagger(mob/M,d) //Technically not a filter, but it relates to drunkenness.
	step(M, pick(d,turn(d,90),turn(d,-90)))

/proc/Ellipsis(original_msg, chance = 50)
	if(chance <= 0) return "..."
	if(chance >= 100) return original_msg

	var/list/words = splittext(original_msg, " ")
	var/list/new_words = list()

	var/new_msg = ""

	for(var/w in words)
		if(prob(chance))
			new_words += "..."
		else
			new_words += w

	new_msg = jointext(new_words," ")

	return new_msg
/*
RadioChat Filter.
args:
message - returns a distorted version of this
distortion_chance - the chance of a filter being applied to each character.
distortion_speed - multiplier for the chance increase.
distortion - starting distortion.
english_only - whether to use traditional english letters only (for use in NanoUI)
*/
/proc/RadioChat(mob/living/user, message, distortion_chance = 60, distortion_speed = 1, distortion = 1, english_only = 0)
	var/datum/language/language
	if(user)
		language = user.get_default_language()
	message = html_decode(message)
	var/new_message = ""
	var/input_size = length(message)
	var/length = 0
	if(input_size < 20) // Short messages get distorted too. Bit hacksy.
		distortion += (20-input_size)/2
	while(length <= input_size)
		var/newletter=copytext(message, length, length+1)
		if(!prob(distortion_chance))
			new_message += newletter
			length += 1
			continue
		if(newletter != " ")
			if(prob(0.08 * distortion)) // Major cutout
				newletter = "*zzzt*"
				length += rand(1, (length(message) - length)) // Skip some characters
				distortion += 1 * distortion_speed
			else if(prob(0.8 * distortion)) // Minor cut out
				if(prob(25))
					newletter = ".."
				else if(prob(25))
					newletter = " "
				else
					newletter = ""
				distortion += 0.25 * distortion_speed
			else if(prob(2 * distortion)) // Mishearing
				if(language && language.syllables && prob(50))
					newletter = pick(language.syllables)
				else
					newletter =	pick("a","e","i","o","u")
				distortion += 0.25 * distortion_speed
			else if(prob(1.5 * distortion)) // Mishearing
				if(language && prob(50))
					if(language.syllables)
						newletter = pick (language.syllables)
					else
						newletter = "*"
				else
					if(english_only)
						newletter += "*"
					else
						newletter = pick("ш", "Р", "%", "ж", "µ")
				distortion += 0.5 * distortion_speed
			else if(prob(0.75 * distortion)) // Incomprehensible
				newletter = pick("<", ">", "!", "$", "%", "^", "&", "*", "~", "#")
				distortion += 0.75 * distortion_speed
			else if(prob(0.05 * distortion)) // Total cut out
				if(!english_only)
					newletter = "¦wЎјb»%> -BZZT-"
				else
					newletter = "srgt%$hjc< -BZZT-"
				new_message += newletter
				break
			else if(prob(2.5 * distortion)) // Sound distortion. Still recognisable, mostly.
				switch(lowertext(newletter))
					if("s")
						newletter = "$"
					if("e")
						newletter = "¬"
					if("w")
						newletter = "ш"
					if("y")
						newletter = "Ў"
					if("x")
						newletter = "ж"
					if("u")
						newletter = "µ"
		else
			if(prob(0.2 * distortion))
				newletter = " *crackle* "
				distortion += 0.25 * distortion_speed
		if(prob(20))
			capitalize(newletter)
		new_message += newletter
		length += 1
	return new_message

// This is prolonged effect, often toggled by prefences
/proc/burr(phrase)
	phrase = html_decode(phrase)
	var/new_phrase = ""
	for(var/i = 1, i <= length_char(phrase), i++)
		var/letter = copytext_char(phrase, i, i + 1)
		if(letter == "р")
			letter = pick("л", "pл", "'л", "p'л")
		else if(letter == "Р")
			letter = pick("Л", "Pл", "'Л", "P'л")
		new_phrase += letter
	return html_encode(new_phrase)

// This is prolonged effect, often toggled by prefences
/proc/lisp(phrase)
	phrase = html_decode(phrase)
	var/list/hissing = list("ж", "ч", "ш", "щ")
	var/new_phrase = ""
	for(var/i = 1, i <= length_char(phrase), i++)
		var/letter = copytext_char(phrase, i, i + 1)
		if(lowertext(letter) in hissing)
			if(lowertext(letter) == letter)
				letter = "ф"
			else
				letter = "Ф"
		new_phrase += letter
	return html_encode(new_phrase)

// Mostly caused by tongue bruising, combines weakened lisping and burring.
/proc/bruisedspeech(phrase)
	phrase = html_decode(phrase)
	var/list/hissing = list("ж", "ч", "ш", "щ")
	var/new_phrase = ""
	for(var/i = 1, i <= length_char(phrase), i++)
		var/letter = copytext_char(phrase, i, i + 1)
		if(prob(50))
			new_phrase += letter
			continue
		if(letter == "р")
			letter = pick("л", "pл", "'л", "p'л")
		else if(letter == "Р")
			letter = pick("Л", "Pл", "'Л", "P'л")
		else if(lowertext(letter) in hissing)
			if(lowertext(letter) == letter)
				letter = "ф"
			else
				letter = "Ф"
		new_phrase += letter
	return html_encode(new_phrase)

// Mostly caused by missing/broken tongues. Removes most consonants.
/proc/mutespeech(phrase, severity = 100)
	phrase = html_decode(phrase)
	var/list/consonants = list(
		"б", "в", "г", "д", "ж", "з", "й", "к", "л", "м", "н", "п", "р", "с", "т", "ф", "х", "ц", "ч", "ш", "щ",
		"b", "c", "d", "f", "g", "h", "j", "k", "l", "m", "n", "p", "q", "r", "s", "t", "v", "x", "z", "w", "y"
		)
	var/new_phrase = ""
	for(var/i = 1, i <= length_char(phrase), i++)
		var/letter = copytext_char(phrase, i, i + 1)
		if(prob(severity) && (lowertext(letter) in consonants))
			continue
		new_phrase += letter
	return html_encode(new_phrase)

/proc/autismspeech(phrase)
	phrase = html_decode(phrase)
	var/new_phrase = ""
	var/current_word = ""
	var/autisticphrase = list("ы-ы-ыЫХ","ОХ-","ааабы","АХ-","хых","Ахы","ыХЫ","АХЫ","пу-пу-пу...","Я УМНЫЙ",
								"Уууу", "аааа", "ыыЫы", "м-м-м", "ээээ", "бр-бр-бр", "гы-гы", "хм-хм","Ва-а")

	for(var/i = 1, i <= length_char(phrase), i++)
		var/char = copytext_char(phrase, i, i + 1)

		// Проверяем, является ли символ буквой (русской или английской) или частью слова
		var/is_letter = is_alpha_char(char) || char == "-" || char == "'" || char == "`"

		if(is_letter)
			current_word += char
		else
			// Если накопилось слово, обрабатываем его
			if(length_char(current_word) > 0)
				if(prob(15)) // проб на замену слова
					new_phrase += pick(autisticphrase)
				else
					new_phrase += slightly_break_word(current_word)
				current_word = ""
			// Добавляем разделитель
			new_phrase += char

	// Обрабатываем последнее слово, если оно есть
	if(length_char(current_word) > 0)
		if(prob(75))
			new_phrase += pick(autisticphrase)
		else
			new_phrase += slightly_break_word(current_word)

	return html_encode(new_phrase)

/proc/is_alpha_char(char)
	// Проверяем, является ли символ буквой (русской или английской)
	var/lower_char = lowertext(char)

	// Проверяем русские буквы
	var/russian_letters = "абвгдеёжзийклмнопрстуфхцчшщъыьэюя"
	if(findtext(russian_letters, lower_char))
		return 1

	// Проверяем английские буквы
	var/english_letters = "abcdefghijklmnopqrstuvwxyz"
	if(findtext(english_letters, lower_char))
		return 1

	return 0

/proc/slightly_break_word(word)
	var/length = length_char(word)

	// Для очень коротких слов оставляем как есть
	if(length <= 2)
		return word

	// Выбираем случайный тип небольшой "поломки"
	var/break_type = rand(1, 5)

	switch(break_type)
		if(1) // Легкая перестановка двух соседних букв
			return swap_two_letters(word)
		if(2) // Замена одной случайной буквы
			return replace_random_letter(word)
		if(3) // Повторение одной случайной буквы
			return repeat_random_letter(word)
		if(4) // Пропуск одной случайной буквы
			return skip_random_letter(word)
		if(5) // Добавление одной случайной буквы
			return add_random_letter(word)

	return word

/proc/swap_two_letters(word)
	var/length = length_char(word)
	if(length < 3)
		return word

	// Выбираем случайную позицию для обмена (кроме последней)
	var/pos = rand(1, length - 1)

	var/result = ""
	for(var/i = 1, i <= length, i++)
		if(i == pos)
			result += copytext_char(word, i + 1, i + 2)
			result += copytext_char(word, i, i + 1)
			i++ // Пропускаем следующую букву, так как мы её уже добавили
		else if(i != pos + 1) // Не добавляем букву, если она была обменена
			result += copytext_char(word, i, i + 1)

	return result

/proc/replace_random_letter(word)
	var/length = length_char(word)
	var/pos = rand(1, length)
	var/letter = copytext_char(word, pos, pos + 1)

	// Таблица замен (просто случайные замены, не обязательно похожие)
	var/list/replacements = list(
		"а" = list("о", "я", "е"),
		"о" = list("а", "ё", "у"),
		"е" = list("э", "и", "е"),
		"и" = list("ы", "й", "и"),
		"у" = list("ю", "ы", "у"),
		"р" = list("л", "рь", "р"),
		"л" = list("р", "ль", "л"),
		"с" = list("з", "сь", "с"),
		"з" = list("с", "зь", "з"),
		"т" = list("д", "ть", "т"),
		"д" = list("т", "дь", "д"),
		"г" = list("к", "гь", "г"),
		"к" = list("г", "кь", "к"),
		"б" = list("п", "бь", "б"),
		"п" = list("б", "пь", "п"),
		"в" = list("ф", "вь", "в"),
		"ф" = list("в", "фь", "ф")
	)

	// Для английских букв
	var/list/en_replacements = list(
		"a" = list("o", "e", "i"),
		"e" = list("a", "i", "o"),
		"i" = list("e", "o", "u"),
		"o" = list("a", "u", "e"),
		"u" = list("o", "i", "a"),
		"r" = list("l", "r", "rh"),
		"l" = list("r", "l", "ll"),
		"s" = list("z", "sh", "s"),
		"z" = list("s", "zh", "z"),
		"t" = list("d", "th", "t"),
		"d" = list("t", "dh", "d"),
		"g" = list("k", "gh", "g"),
		"k" = list("g", "kh", "k"),
		"b" = list("p", "bh", "b"),
		"p" = list("b", "ph", "p"),
		"v" = list("f", "vh", "v"),
		"f" = list("v", "ph", "f")
	)

	var/lower_letter = lowertext(letter)
	var/new_letter = lower_letter

	// Пытаемся найти замену
	if(lower_letter in replacements)
		var/list/options = replacements[lower_letter]
		new_letter = pick(options)
	else if(lower_letter in en_replacements)
		var/list/options = en_replacements[lower_letter]
		new_letter = pick(options)

	// Сохраняем регистр
	if(letter != lower_letter) // Если оригинальная буква была заглавной
		new_letter = uppertext(new_letter)

	// Собираем слово с заменой
	var/result = ""
	for(var/i = 1, i <= length, i++)
		if(i == pos)
			result += new_letter
		else
			result += copytext_char(word, i, i + 1)

	return result

/proc/repeat_random_letter(word)
	var/length = length_char(word)
	var/pos = rand(1, length)
	var/letter = copytext_char(word, pos, pos + 1)

	// Собираем слово с повторением одной буквы
	var/result = ""
	for(var/i = 1, i <= length, i++)
		result += copytext_char(word, i, i + 1)
		if(i == pos)
			result += letter // Добавляем ту же букву ещё раз

	return result

/proc/skip_random_letter(word)
	var/length = length_char(word)
	if(length <= 3)
		return word

	var/pos = rand(1, length)

	// Собираем слово без одной буквы
	var/result = ""
	for(var/i = 1, i <= length, i++)
		if(i != pos)
			result += copytext_char(word, i, i + 1)

	return result

/proc/add_random_letter(word)
	var/length = length_char(word)
	var/pos = rand(1, length + 1)

	// Случайные буквы для добавления
	var/list/common_letters = list("а", "о", "е", "и", "н", "т", "с", "р", "в", "л", "к", "м", "д", "п", "у", "я", "ы", "ь", "г", "з", "б", "ч", "й", "х", "ж", "ш", "ю", "ц", "щ", "э", "ф")
	var/list/common_en_letters = list("a", "e", "i", "o", "u", "n", "t", "s", "r", "h", "l", "d", "c", "m", "f", "p", "g", "w", "y", "b", "v", "k", "x", "j", "q", "z")

	// Определяем, какая буква больше подходит на основе слова
	var/add_letter = pick(common_letters + common_en_letters) // Смешиваем оба списка

	// Проверяем, есть ли в слове русские буквы
	var/has_russian = 0
	for(var/i = 1, i <= length, i++)
		var/char = copytext_char(word, i, i + 1)
		if(is_alpha_char(char))
			var/lower_char = lowertext(char)
			var/russian_letters = "абвгдеёжзийклмнопрстуфхцчшщъыьэюя"
			if(findtext(russian_letters, lower_char))
				has_russian = 1
				break

	// Если в слове есть русские буквы, стараемся использовать русскую букву
	if(has_russian && prob(80))
		add_letter = pick(common_letters)

	// Смотрим на регистр соседних букв
	if(pos <= length)
		var/neighbor = copytext_char(word, pos, pos + 1)
		if(neighbor == uppertext(neighbor))
			add_letter = uppertext(add_letter)

	// Собираем слово с добавленной буквой
	var/result = ""
	for(var/i = 1, i <= length, i++)
		if(i == pos)
			result += add_letter
		result += copytext_char(word, i, i + 1)

	// Если добавляем в конец
	if(pos == length + 1)
		result += add_letter

	return result
