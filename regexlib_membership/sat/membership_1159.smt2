;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(\$\ |\$)?((0|00|[1-9]\d*|([1-9]\d{0,2}(\,\d{3})*))(\.\d{1,4})?|(\.\d{1,4}))$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: ".8"
(define-fun Witness1 () String (str.++ "." (str.++ "8" "")))
;witness2: "1.0"
(define-fun Witness2 () String (str.++ "1" (str.++ "." (str.++ "0" ""))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.opt (re.union (str.to_re (str.++ "$" (str.++ " " ""))) (re.range "$" "$")))(re.++ (re.union (re.++ (re.union (re.range "0" "0")(re.union (str.to_re (str.++ "0" (str.++ "0" "")))(re.union (re.++ (re.range "1" "9") (re.* (re.range "0" "9"))) (re.++ (re.range "1" "9")(re.++ ((_ re.loop 0 2) (re.range "0" "9")) (re.* (re.++ (re.range "," ",") ((_ re.loop 3 3) (re.range "0" "9"))))))))) (re.opt (re.++ (re.range "." ".") ((_ re.loop 1 4) (re.range "0" "9"))))) (re.++ (re.range "." ".") ((_ re.loop 1 4) (re.range "0" "9")))) (str.to_re ""))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
