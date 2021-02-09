;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = &amp;\"\x00"*(0|1|2|3|4|5|6|7|8|B|C|E|F|10|11|12|13|14|15|16|17|18|19|1A|1B|1C|1D|1E|1F);
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "\u009F{\u00DA&amp;"\x1e";"
(define-fun Witness1 () String (seq.++ "\x9f" (seq.++ "{" (seq.++ "\xda" (seq.++ "&" (seq.++ "a" (seq.++ "m" (seq.++ "p" (seq.++ ";" (seq.++ "#" (seq.++ "x" (seq.++ "0" (seq.++ "0" (seq.++ "1" (seq.++ "E" (seq.++ ";" ""))))))))))))))))
;witness2: "&amp;"\x19";"
(define-fun Witness2 () String (seq.++ "&" (seq.++ "a" (seq.++ "m" (seq.++ "p" (seq.++ ";" (seq.++ "#" (seq.++ "x" (seq.++ "0" (seq.++ "0" (seq.++ "1" (seq.++ "9" (seq.++ ";" "")))))))))))))

(assert (= regexA (re.++ (str.to_re (seq.++ "&" (seq.++ "a" (seq.++ "m" (seq.++ "p" (seq.++ ";" (seq.++ "#" (seq.++ "x" ""))))))))(re.++ (re.* (re.range "0" "0"))(re.++ (re.union (re.union (re.range "0" "8")(re.union (re.range "B" "C") (re.range "E" "F")))(re.union (str.to_re (seq.++ "1" (seq.++ "0" "")))(re.union (str.to_re (seq.++ "1" (seq.++ "1" "")))(re.union (str.to_re (seq.++ "1" (seq.++ "2" "")))(re.union (str.to_re (seq.++ "1" (seq.++ "3" "")))(re.union (str.to_re (seq.++ "1" (seq.++ "4" "")))(re.union (str.to_re (seq.++ "1" (seq.++ "5" "")))(re.union (str.to_re (seq.++ "1" (seq.++ "6" "")))(re.union (str.to_re (seq.++ "1" (seq.++ "7" "")))(re.union (str.to_re (seq.++ "1" (seq.++ "8" "")))(re.union (str.to_re (seq.++ "1" (seq.++ "9" "")))(re.union (str.to_re (seq.++ "1" (seq.++ "A" "")))(re.union (str.to_re (seq.++ "1" (seq.++ "B" "")))(re.union (str.to_re (seq.++ "1" (seq.++ "C" "")))(re.union (str.to_re (seq.++ "1" (seq.++ "D" "")))(re.union (str.to_re (seq.++ "1" (seq.++ "E" ""))) (str.to_re (seq.++ "1" (seq.++ "F" ""))))))))))))))))))) (re.range ";" ";"))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
