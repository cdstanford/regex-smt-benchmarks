;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^\({0,1}0(2|3|7|8)\){0,1}(\ |-){0,1}[0-9]{4}(\ |-){0,1}[0-9]{4}$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "07)28870319"
(define-fun Witness1 () String (seq.++ "0" (seq.++ "7" (seq.++ ")" (seq.++ "2" (seq.++ "8" (seq.++ "8" (seq.++ "7" (seq.++ "0" (seq.++ "3" (seq.++ "1" (seq.++ "9" ""))))))))))))
;witness2: "(037983 7989"
(define-fun Witness2 () String (seq.++ "(" (seq.++ "0" (seq.++ "3" (seq.++ "7" (seq.++ "9" (seq.++ "8" (seq.++ "3" (seq.++ " " (seq.++ "7" (seq.++ "9" (seq.++ "8" (seq.++ "9" "")))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.opt (re.range "(" "("))(re.++ (re.range "0" "0")(re.++ (re.union (re.range "2" "3") (re.range "7" "8"))(re.++ (re.opt (re.range ")" ")"))(re.++ (re.opt (re.union (re.range " " " ") (re.range "-" "-")))(re.++ ((_ re.loop 4 4) (re.range "0" "9"))(re.++ (re.opt (re.union (re.range " " " ") (re.range "-" "-")))(re.++ ((_ re.loop 4 4) (re.range "0" "9")) (str.to_re ""))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
