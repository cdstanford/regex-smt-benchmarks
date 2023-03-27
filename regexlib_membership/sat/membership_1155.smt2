;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = &amp;\"\u{00}"*(0|1|2|3|4|5|6|7|8|B|C|E|F|10|11|12|13|14|15|16|17|18|19|1A|1B|1C|1D|1E|1F);
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "\u009F{\u00DA&amp;"\u{1e}";"
(define-fun Witness1 () String (str.++ "\u{9f}" (str.++ "{" (str.++ "\u{da}" (str.++ "&" (str.++ "a" (str.++ "m" (str.++ "p" (str.++ ";" (str.++ "#" (str.++ "x" (str.++ "0" (str.++ "0" (str.++ "1" (str.++ "E" (str.++ ";" ""))))))))))))))))
;witness2: "&amp;"\u{19}";"
(define-fun Witness2 () String (str.++ "&" (str.++ "a" (str.++ "m" (str.++ "p" (str.++ ";" (str.++ "#" (str.++ "x" (str.++ "0" (str.++ "0" (str.++ "1" (str.++ "9" (str.++ ";" "")))))))))))))

(assert (= regexA (re.++ (str.to_re (str.++ "&" (str.++ "a" (str.++ "m" (str.++ "p" (str.++ ";" (str.++ "#" (str.++ "x" ""))))))))(re.++ (re.* (re.range "0" "0"))(re.++ (re.union (re.union (re.range "0" "8")(re.union (re.range "B" "C") (re.range "E" "F")))(re.union (str.to_re (str.++ "1" (str.++ "0" "")))(re.union (str.to_re (str.++ "1" (str.++ "1" "")))(re.union (str.to_re (str.++ "1" (str.++ "2" "")))(re.union (str.to_re (str.++ "1" (str.++ "3" "")))(re.union (str.to_re (str.++ "1" (str.++ "4" "")))(re.union (str.to_re (str.++ "1" (str.++ "5" "")))(re.union (str.to_re (str.++ "1" (str.++ "6" "")))(re.union (str.to_re (str.++ "1" (str.++ "7" "")))(re.union (str.to_re (str.++ "1" (str.++ "8" "")))(re.union (str.to_re (str.++ "1" (str.++ "9" "")))(re.union (str.to_re (str.++ "1" (str.++ "A" "")))(re.union (str.to_re (str.++ "1" (str.++ "B" "")))(re.union (str.to_re (str.++ "1" (str.++ "C" "")))(re.union (str.to_re (str.++ "1" (str.++ "D" "")))(re.union (str.to_re (str.++ "1" (str.++ "E" ""))) (str.to_re (str.++ "1" (str.++ "F" ""))))))))))))))))))) (re.range ";" ";"))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
