;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ([0-8][0-9]|[9][0])°' '[0-9][0-9]\.[0-9]´' '[NS]
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "90\u00B0\' \'28.8\u00B4\' \'N"
(define-fun Witness1 () String (str.++ "9" (str.++ "0" (str.++ "\u{b0}" (str.++ "'" (str.++ " " (str.++ "'" (str.++ "2" (str.++ "8" (str.++ "." (str.++ "8" (str.++ "\u{b4}" (str.++ "'" (str.++ " " (str.++ "'" (str.++ "N" ""))))))))))))))))
;witness2: "90\u00B0\' \'71.9\u00B4\' \'S"
(define-fun Witness2 () String (str.++ "9" (str.++ "0" (str.++ "\u{b0}" (str.++ "'" (str.++ " " (str.++ "'" (str.++ "7" (str.++ "1" (str.++ "." (str.++ "9" (str.++ "\u{b4}" (str.++ "'" (str.++ " " (str.++ "'" (str.++ "S" ""))))))))))))))))

(assert (= regexA (re.++ (re.union (re.++ (re.range "0" "8") (re.range "0" "9")) (str.to_re (str.++ "9" (str.++ "0" ""))))(re.++ (str.to_re (str.++ "\u{b0}" (str.++ "'" (str.++ " " (str.++ "'" "")))))(re.++ (re.range "0" "9")(re.++ (re.range "0" "9")(re.++ (re.range "." ".")(re.++ (re.range "0" "9")(re.++ (str.to_re (str.++ "\u{b4}" (str.++ "'" (str.++ " " (str.++ "'" ""))))) (re.union (re.range "N" "N") (re.range "S" "S")))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
