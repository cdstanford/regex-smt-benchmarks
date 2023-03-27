;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (([01][0-7]|[00][0-9])[0-9]|[1][8][0])°' '[0-9][0-9]\.[0-9]´' '[EW]
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "\u00E0180\u00B0\' \'39.9\u00B4\' \'W"
(define-fun Witness1 () String (str.++ "\u{e0}" (str.++ "1" (str.++ "8" (str.++ "0" (str.++ "\u{b0}" (str.++ "'" (str.++ " " (str.++ "'" (str.++ "3" (str.++ "9" (str.++ "." (str.++ "9" (str.++ "\u{b4}" (str.++ "'" (str.++ " " (str.++ "'" (str.++ "W" ""))))))))))))))))))
;witness2: "\u00E8119\u00B0\' \'05.1\u00B4\' \'W"
(define-fun Witness2 () String (str.++ "\u{e8}" (str.++ "1" (str.++ "1" (str.++ "9" (str.++ "\u{b0}" (str.++ "'" (str.++ " " (str.++ "'" (str.++ "0" (str.++ "5" (str.++ "." (str.++ "1" (str.++ "\u{b4}" (str.++ "'" (str.++ " " (str.++ "'" (str.++ "W" ""))))))))))))))))))

(assert (= regexA (re.++ (re.union (re.++ (re.union (re.++ (re.range "0" "1") (re.range "0" "7")) (re.++ (re.range "0" "0") (re.range "0" "9"))) (re.range "0" "9")) (str.to_re (str.++ "1" (str.++ "8" (str.++ "0" "")))))(re.++ (str.to_re (str.++ "\u{b0}" (str.++ "'" (str.++ " " (str.++ "'" "")))))(re.++ (re.range "0" "9")(re.++ (re.range "0" "9")(re.++ (re.range "." ".")(re.++ (re.range "0" "9")(re.++ (str.to_re (str.++ "\u{b4}" (str.++ "'" (str.++ " " (str.++ "'" ""))))) (re.union (re.range "E" "E") (re.range "W" "W")))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
