
count_minutes(ByRef counter)
{
	Sleep, 1000
	counter++
}

word_from_array(array, ByRef counter)
{
	Send {array[counter]}
	counter++
}

count_elements(file)
{
	counter := 0
	Loop, read, .\bases\%file%
	{	
		Loop, parse, A_LoopReadLine, %A_Tab%
		{
			counter++
		} 	
	}
	return counter
}

count_array_elements(array)
{
	counter := 0
	
	Loop
	{
		if (array[counter] == "")
			return counter
		counter++
	}
}

insert_into_array(file, filter1:="", filter2:="", position:="", array:="")
{
	counter := 0
	i := 0
	Loop, read, .\bases\%file%
	{	
		Loop, parse, A_LoopReadLine, %A_Tab%
		{
			string := A_LoopField
			word_array := StrSplit(string, ";")  ; Omits periods.
			
			array[counter] := word_array[position]
			counter++
		} 
	}
	return
}


count_unique_elements(array, element)
{
	counter := 0
	doc_index := 0
	while (true)
	{
		
		if (array[doc_index] == "")
		{
			break
		}
		if (array[doc_index] == element)
		{
			;MsgBox % array[doc_index] . "=" . element
			
			if (array[doc_index] == array[doc_index + 1])
			{
				doc_index++
				counter++
			}
			else
			{
				counter++
				break
			}
		}
		else
		{
			doc_index++
		}
	}
	return counter
}
/*
count_unique_elements(array, ByRef doc_index)
{
	counter := 0
	while (true)
	{
		
		if (array[doc_index] == "")
		{
			break
		}
		
		
		if (array[doc_index] == array[doc_index + 1])
		{
			doc_index++
			counter++
		}
		else
		{
			counter++
			break
		}
	}
	return counter
}
*/

get_name(codes_array, names_array, size, value)
{
	i := 0
	Loop, %size%
	{
		if (value == codes_array[i])
		{
			value := names_array[i]
		}
		i++
	}
	return value
}

find(array, size, value)
{
	i := 0
	Loop, %size%
	{
		if (value == array[i])
		{
			return true
		}
		i++
	}
	return false
}

find_where(array, size, value)
{
	i := 0
	Loop, %size%
	{
		if (value == array[i])
		{
			return i
		}
		i++
	}
	return false
}

find_bin(array, size, search_val)
{
	first_el := 0
	last := size - 1

	while (first_el <= last) 
	{
		middle := round((first_el + last) / 2)
		
		if (array[middle] == search_val) 
			return middle
		else if (array[middle] < search_val)
			first_el := middle + 1
		else
			last := middle - 1
	}
	if (first_el > last)
		return false
}