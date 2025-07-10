;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^\({0,1}0(2|3|7|8)\){0,1}(\ |-){0,1}[0-9]{4}(\ |-){0,1}[0-9]{4}$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "07)28870319"
(define-fun Witness1 () String (str.++ "0" (str.++ "7" (str.++ ")" (str.++ "2" (str.++ "8" (str.++ "8" (str.++ "7" (str.++ "0" (str.++ "3" (str.++ "1" (str.++ "9" ""))))))))))))
;witness2: "(037983 7989"
(define-fun Witness2 () String (str.++ "(" (str.++ "0" (str.++ "3" (str.++ "7" (str.++ "9" (str.++ "8" (str.++ "3" (str.++ " " (str.++ "7" (str.++ "9" (str.++ "8" (str.++ "9" "")))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.opt (re.range "(" "("))(re.++ (re.range "0" "0")(re.++ (re.union (re.range "2" "3") (re.range "7" "8"))(re.++ (re.opt (re.range ")" ")"))(re.++ (re.opt (re.union (re.range " " " ") (re.range "-" "-")))(re.++ ((_ re.loop 4 4) (re.range "0" "9"))(re.++ (re.opt (re.union (re.range " " " ") (re.range "-" "-")))(re.++ ((_ re.loop 4 4) (re.range "0" "9")) (str.to_re ""))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
