;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = \.?[a-zA-Z0-9]{1,}$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "s"
(define-fun Witness1 () String (str.++ "s" ""))
;witness2: "\u00E3D9"
(define-fun Witness2 () String (str.++ "\u{e3}" (str.++ "D" (str.++ "9" ""))))

(assert (= regexA (re.++ (re.opt (re.range "." "."))(re.++ (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z")))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
