;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = \(([0-9]{2}|0{1}((x|[0-9]){2}[0-9]{2}))\)\s*[0-9]{3,4}[- ]*[0-9]{4}
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "(19)398- 7878"
(define-fun Witness1 () String (str.++ "(" (str.++ "1" (str.++ "9" (str.++ ")" (str.++ "3" (str.++ "9" (str.++ "8" (str.++ "-" (str.++ " " (str.++ "7" (str.++ "8" (str.++ "7" (str.++ "8" ""))))))))))))))
;witness2: "\u00E5(0xx89)8996-2099"
(define-fun Witness2 () String (str.++ "\u{e5}" (str.++ "(" (str.++ "0" (str.++ "x" (str.++ "x" (str.++ "8" (str.++ "9" (str.++ ")" (str.++ "8" (str.++ "9" (str.++ "9" (str.++ "6" (str.++ "-" (str.++ "2" (str.++ "0" (str.++ "9" (str.++ "9" ""))))))))))))))))))

(assert (= regexA (re.++ (re.range "(" "(")(re.++ (re.union ((_ re.loop 2 2) (re.range "0" "9")) (re.++ (re.range "0" "0") (re.++ ((_ re.loop 2 2) (re.union (re.range "0" "9") (re.range "x" "x"))) ((_ re.loop 2 2) (re.range "0" "9")))))(re.++ (re.range ")" ")")(re.++ (re.* (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ ((_ re.loop 3 4) (re.range "0" "9"))(re.++ (re.* (re.union (re.range " " " ") (re.range "-" "-"))) ((_ re.loop 4 4) (re.range "0" "9"))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
