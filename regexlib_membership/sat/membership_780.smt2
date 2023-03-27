;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^0?.[0]{1,2}[1-9]{1}$|^0?.[1-9]{1}?\d{0,2}$|^(1|1.{1}[0]{1,3})$|^0?.[0]{1}[1-9]{1}\d{1}$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "0\u00A83"
(define-fun Witness1 () String (str.++ "0" (str.++ "\u{a8}" (str.++ "3" ""))))
;witness2: "0\u0099007"
(define-fun Witness2 () String (str.++ "0" (str.++ "\u{99}" (str.++ "0" (str.++ "0" (str.++ "7" ""))))))

(assert (= regexA (re.union (re.++ (str.to_re "")(re.++ (re.opt (re.range "0" "0"))(re.++ (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}"))(re.++ ((_ re.loop 1 2) (re.range "0" "0"))(re.++ (re.range "1" "9") (str.to_re ""))))))(re.union (re.++ (str.to_re "")(re.++ (re.opt (re.range "0" "0"))(re.++ (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}"))(re.++ (re.range "1" "9")(re.++ ((_ re.loop 0 2) (re.range "0" "9")) (str.to_re ""))))))(re.union (re.++ (str.to_re "")(re.++ (re.union (re.range "1" "1") (re.++ (re.range "1" "1")(re.++ (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}")) ((_ re.loop 1 3) (re.range "0" "0"))))) (str.to_re ""))) (re.++ (str.to_re "")(re.++ (re.opt (re.range "0" "0"))(re.++ (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}"))(re.++ (re.range "0" "0")(re.++ (re.range "1" "9")(re.++ (re.range "0" "9") (str.to_re ""))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
