;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = href[ ]*=[ ]*('|\&quot;)([^\&quot;'])*('|\&quot;)
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "href=\'&quot;\u00A3\x11\u0088\u00A2|"
(define-fun Witness1 () String (seq.++ "h" (seq.++ "r" (seq.++ "e" (seq.++ "f" (seq.++ "=" (seq.++ "'" (seq.++ "&" (seq.++ "q" (seq.++ "u" (seq.++ "o" (seq.++ "t" (seq.++ ";" (seq.++ "\xa3" (seq.++ "\x11" (seq.++ "\x88" (seq.++ "\xa2" (seq.++ "|" ""))))))))))))))))))
;witness2: "\u00C7;href=      &quot;\u007F\u00BF\x4&quot;\u00D5"
(define-fun Witness2 () String (seq.++ "\xc7" (seq.++ ";" (seq.++ "h" (seq.++ "r" (seq.++ "e" (seq.++ "f" (seq.++ "=" (seq.++ " " (seq.++ " " (seq.++ " " (seq.++ " " (seq.++ " " (seq.++ " " (seq.++ "&" (seq.++ "q" (seq.++ "u" (seq.++ "o" (seq.++ "t" (seq.++ ";" (seq.++ "\x7f" (seq.++ "\xbf" (seq.++ "\x04" (seq.++ "&" (seq.++ "q" (seq.++ "u" (seq.++ "o" (seq.++ "t" (seq.++ ";" (seq.++ "\xd5" ""))))))))))))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re (seq.++ "h" (seq.++ "r" (seq.++ "e" (seq.++ "f" "")))))(re.++ (re.* (re.range " " " "))(re.++ (re.range "=" "=")(re.++ (re.* (re.range " " " "))(re.++ (re.union (re.range "'" "'") (str.to_re (seq.++ "&" (seq.++ "q" (seq.++ "u" (seq.++ "o" (seq.++ "t" (seq.++ ";" ""))))))))(re.++ (re.* (re.union (re.range "\x00" "%")(re.union (re.range "(" ":")(re.union (re.range "<" "n")(re.union (re.range "p" "p")(re.union (re.range "r" "s") (re.range "v" "\xff"))))))) (re.union (re.range "'" "'") (str.to_re (seq.++ "&" (seq.++ "q" (seq.++ "u" (seq.++ "o" (seq.++ "t" (seq.++ ";" ""))))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
