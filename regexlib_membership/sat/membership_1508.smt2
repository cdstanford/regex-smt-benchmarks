;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(((\d{1,3})(,\d{3})*)|(\d+))(.\d+)?$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "0v319"
(define-fun Witness1 () String (str.++ "0" (str.++ "v" (str.++ "3" (str.++ "1" (str.++ "9" ""))))))
;witness2: "060}6"
(define-fun Witness2 () String (str.++ "0" (str.++ "6" (str.++ "0" (str.++ "}" (str.++ "6" ""))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.++ ((_ re.loop 1 3) (re.range "0" "9")) (re.* (re.++ (re.range "," ",") ((_ re.loop 3 3) (re.range "0" "9"))))) (re.+ (re.range "0" "9")))(re.++ (re.opt (re.++ (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}")) (re.+ (re.range "0" "9")))) (str.to_re ""))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
