;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = \(([0-9]{2}|0{1}((x|[0-9]){2}[0-9]{2}))\)\s*[0-9]{3,4}[- ]*[0-9]{4}
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "(19)398- 7878"
(define-fun Witness1 () String (seq.++ "(" (seq.++ "1" (seq.++ "9" (seq.++ ")" (seq.++ "3" (seq.++ "9" (seq.++ "8" (seq.++ "-" (seq.++ " " (seq.++ "7" (seq.++ "8" (seq.++ "7" (seq.++ "8" ""))))))))))))))
;witness2: "\u00E5(0xx89)8996-2099"
(define-fun Witness2 () String (seq.++ "\xe5" (seq.++ "(" (seq.++ "0" (seq.++ "x" (seq.++ "x" (seq.++ "8" (seq.++ "9" (seq.++ ")" (seq.++ "8" (seq.++ "9" (seq.++ "9" (seq.++ "6" (seq.++ "-" (seq.++ "2" (seq.++ "0" (seq.++ "9" (seq.++ "9" ""))))))))))))))))))

(assert (= regexA (re.++ (re.range "(" "(")(re.++ (re.union ((_ re.loop 2 2) (re.range "0" "9")) (re.++ (re.range "0" "0") (re.++ ((_ re.loop 2 2) (re.union (re.range "0" "9") (re.range "x" "x"))) ((_ re.loop 2 2) (re.range "0" "9")))))(re.++ (re.range ")" ")")(re.++ (re.* (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))(re.++ ((_ re.loop 3 4) (re.range "0" "9"))(re.++ (re.* (re.union (re.range " " " ") (re.range "-" "-"))) ((_ re.loop 4 4) (re.range "0" "9"))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
