;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = href[\s]*=[\s]*&quot;[^\n&quot;]*&quot;
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "\u00E1href=&quot;&quot;!"
(define-fun Witness1 () String (seq.++ "\xe1" (seq.++ "h" (seq.++ "r" (seq.++ "e" (seq.++ "f" (seq.++ "=" (seq.++ "&" (seq.++ "q" (seq.++ "u" (seq.++ "o" (seq.++ "t" (seq.++ ";" (seq.++ "&" (seq.++ "q" (seq.++ "u" (seq.++ "o" (seq.++ "t" (seq.++ ";" (seq.++ "!" ""))))))))))))))))))))
;witness2: "href\u00A0 =\u0085\u00A0&quot;&quot;"
(define-fun Witness2 () String (seq.++ "h" (seq.++ "r" (seq.++ "e" (seq.++ "f" (seq.++ "\xa0" (seq.++ " " (seq.++ "=" (seq.++ "\x85" (seq.++ "\xa0" (seq.++ "&" (seq.++ "q" (seq.++ "u" (seq.++ "o" (seq.++ "t" (seq.++ ";" (seq.++ "&" (seq.++ "q" (seq.++ "u" (seq.++ "o" (seq.++ "t" (seq.++ ";" ""))))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re (seq.++ "h" (seq.++ "r" (seq.++ "e" (seq.++ "f" "")))))(re.++ (re.* (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))(re.++ (re.range "=" "=")(re.++ (re.* (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))(re.++ (str.to_re (seq.++ "&" (seq.++ "q" (seq.++ "u" (seq.++ "o" (seq.++ "t" (seq.++ ";" "")))))))(re.++ (re.* (re.union (re.range "\x00" "\x09")(re.union (re.range "\x0b" "%")(re.union (re.range "'" ":")(re.union (re.range "<" "n")(re.union (re.range "p" "p")(re.union (re.range "r" "s") (re.range "v" "\xff")))))))) (str.to_re (seq.++ "&" (seq.++ "q" (seq.++ "u" (seq.++ "o" (seq.++ "t" (seq.++ ";" "")))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
