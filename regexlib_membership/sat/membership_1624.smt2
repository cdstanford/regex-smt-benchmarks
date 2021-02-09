;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[a-z0-9][a-z0-9_\.-]{0,}[a-z0-9]@[a-z0-9][a-z0-9_\.-]{0,}[a-z0-9][\.][a-z0-9]{2,4}$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "t_o@j9.bs9"
(define-fun Witness1 () String (seq.++ "t" (seq.++ "_" (seq.++ "o" (seq.++ "@" (seq.++ "j" (seq.++ "9" (seq.++ "." (seq.++ "b" (seq.++ "s" (seq.++ "9" "")))))))))))
;witness2: "4_7d@19p.vq"
(define-fun Witness2 () String (seq.++ "4" (seq.++ "_" (seq.++ "7" (seq.++ "d" (seq.++ "@" (seq.++ "1" (seq.++ "9" (seq.++ "p" (seq.++ "." (seq.++ "v" (seq.++ "q" ""))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.range "0" "9") (re.range "a" "z"))(re.++ (re.* (re.union (re.range "-" ".")(re.union (re.range "0" "9")(re.union (re.range "_" "_") (re.range "a" "z")))))(re.++ (re.union (re.range "0" "9") (re.range "a" "z"))(re.++ (re.range "@" "@")(re.++ (re.union (re.range "0" "9") (re.range "a" "z"))(re.++ (re.* (re.union (re.range "-" ".")(re.union (re.range "0" "9")(re.union (re.range "_" "_") (re.range "a" "z")))))(re.++ (re.union (re.range "0" "9") (re.range "a" "z"))(re.++ (re.range "." ".")(re.++ ((_ re.loop 2 4) (re.union (re.range "0" "9") (re.range "a" "z"))) (str.to_re "")))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
