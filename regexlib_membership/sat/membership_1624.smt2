;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[a-z0-9][a-z0-9_\.-]{0,}[a-z0-9]@[a-z0-9][a-z0-9_\.-]{0,}[a-z0-9][\.][a-z0-9]{2,4}$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "t_o@j9.bs9"
(define-fun Witness1 () String (str.++ "t" (str.++ "_" (str.++ "o" (str.++ "@" (str.++ "j" (str.++ "9" (str.++ "." (str.++ "b" (str.++ "s" (str.++ "9" "")))))))))))
;witness2: "4_7d@19p.vq"
(define-fun Witness2 () String (str.++ "4" (str.++ "_" (str.++ "7" (str.++ "d" (str.++ "@" (str.++ "1" (str.++ "9" (str.++ "p" (str.++ "." (str.++ "v" (str.++ "q" ""))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.range "0" "9") (re.range "a" "z"))(re.++ (re.* (re.union (re.range "-" ".")(re.union (re.range "0" "9")(re.union (re.range "_" "_") (re.range "a" "z")))))(re.++ (re.union (re.range "0" "9") (re.range "a" "z"))(re.++ (re.range "@" "@")(re.++ (re.union (re.range "0" "9") (re.range "a" "z"))(re.++ (re.* (re.union (re.range "-" ".")(re.union (re.range "0" "9")(re.union (re.range "_" "_") (re.range "a" "z")))))(re.++ (re.union (re.range "0" "9") (re.range "a" "z"))(re.++ (re.range "." ".")(re.++ ((_ re.loop 2 4) (re.union (re.range "0" "9") (re.range "a" "z"))) (str.to_re "")))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
