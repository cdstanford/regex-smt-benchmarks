;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[a-z]+([a-z0-9-]*[a-z0-9]+)?(\.([a-z]+([a-z0-9-]*[a-z0-9]+)?)+)*$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "w"
(define-fun Witness1 () String (str.++ "w" ""))
;witness2: "vfin89"
(define-fun Witness2 () String (str.++ "v" (str.++ "f" (str.++ "i" (str.++ "n" (str.++ "8" (str.++ "9" "")))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.+ (re.range "a" "z"))(re.++ (re.opt (re.++ (re.* (re.union (re.range "-" "-")(re.union (re.range "0" "9") (re.range "a" "z")))) (re.+ (re.union (re.range "0" "9") (re.range "a" "z")))))(re.++ (re.* (re.++ (re.range "." ".") (re.+ (re.++ (re.+ (re.range "a" "z")) (re.opt (re.++ (re.* (re.union (re.range "-" "-")(re.union (re.range "0" "9") (re.range "a" "z")))) (re.+ (re.union (re.range "0" "9") (re.range "a" "z"))))))))) (str.to_re "")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
