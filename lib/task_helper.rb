module TaskHelper
	def self.fix_reserved_words(word)
		reserved = ['end', 'else', 'nil', 'true', 'alias', 'elsif', 'not', 'undef',
			'and', 'end', 'or', 'unless', 'begin', 'ensure', 'redo', 'until', 'break',
			'false', 'rescue', 'when', 'case', 'for', 'retry', 'while', 'class', 'if',
			'return', 'def', 'in', 'self', 'defined?', 'module', 'super', 'name']
		if (reserved.include?(word))
			return "_#{word}"
		else
			return word
		end
	end
end
