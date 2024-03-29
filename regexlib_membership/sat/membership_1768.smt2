;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^\d*[0-9](|.\d*[0-9]|,\d*[0-9])?$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "8"
(define-fun Witness1 () String (str.++ "8" ""))
;witness2: "9"
(define-fun Witness2 () String (str.++ "9" ""))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.* (re.range "0" "9"))(re.++ (re.range "0" "9")(re.++ (re.opt (re.union (str.to_re "")(re.union (re.++ (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}"))(re.++ (re.* (re.range "0" "9")) (re.range "0" "9"))) (re.++ (re.range "," ",")(re.++ (re.* (re.range "0" "9")) (re.range "0" "9")))))) (str.to_re "")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
