;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[a-zA-z0-9]+[@]{1}[a-zA-Z]+[.]{1}[a-zA-Z]+$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "qC8@H.m"
(define-fun Witness1 () String (str.++ "q" (str.++ "C" (str.++ "8" (str.++ "@" (str.++ "H" (str.++ "." (str.++ "m" ""))))))))
;witness2: "9N@YS.a"
(define-fun Witness2 () String (str.++ "9" (str.++ "N" (str.++ "@" (str.++ "Y" (str.++ "S" (str.++ "." (str.++ "a" ""))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.+ (re.union (re.range "0" "9") (re.range "A" "z")))(re.++ (re.range "@" "@")(re.++ (re.+ (re.union (re.range "A" "Z") (re.range "a" "z")))(re.++ (re.range "." ".")(re.++ (re.+ (re.union (re.range "A" "Z") (re.range "a" "z"))) (str.to_re "")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
