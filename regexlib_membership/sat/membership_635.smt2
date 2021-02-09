;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (([01][0-7]|[00][0-9])[0-9]|[1][8][0])°' '[0-9][0-9]\.[0-9]´' '[EW]
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "\u00E0180\u00B0\' \'39.9\u00B4\' \'W"
(define-fun Witness1 () String (seq.++ "\xe0" (seq.++ "1" (seq.++ "8" (seq.++ "0" (seq.++ "\xb0" (seq.++ "'" (seq.++ " " (seq.++ "'" (seq.++ "3" (seq.++ "9" (seq.++ "." (seq.++ "9" (seq.++ "\xb4" (seq.++ "'" (seq.++ " " (seq.++ "'" (seq.++ "W" ""))))))))))))))))))
;witness2: "\u00E8119\u00B0\' \'05.1\u00B4\' \'W"
(define-fun Witness2 () String (seq.++ "\xe8" (seq.++ "1" (seq.++ "1" (seq.++ "9" (seq.++ "\xb0" (seq.++ "'" (seq.++ " " (seq.++ "'" (seq.++ "0" (seq.++ "5" (seq.++ "." (seq.++ "1" (seq.++ "\xb4" (seq.++ "'" (seq.++ " " (seq.++ "'" (seq.++ "W" ""))))))))))))))))))

(assert (= regexA (re.++ (re.union (re.++ (re.union (re.++ (re.range "0" "1") (re.range "0" "7")) (re.++ (re.range "0" "0") (re.range "0" "9"))) (re.range "0" "9")) (str.to_re (seq.++ "1" (seq.++ "8" (seq.++ "0" "")))))(re.++ (str.to_re (seq.++ "\xb0" (seq.++ "'" (seq.++ " " (seq.++ "'" "")))))(re.++ (re.range "0" "9")(re.++ (re.range "0" "9")(re.++ (re.range "." ".")(re.++ (re.range "0" "9")(re.++ (str.to_re (seq.++ "\xb4" (seq.++ "'" (seq.++ " " (seq.++ "'" ""))))) (re.union (re.range "E" "E") (re.range "W" "W")))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
