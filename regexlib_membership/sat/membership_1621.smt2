;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^([a-zA-Z0-9]([a-zA-Z0-9\-]{0,61}[a-zA-Z0-9])?\.)+[a-zA-Z]{2,6}$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "01.tD"
(define-fun Witness1 () String (seq.++ "0" (seq.++ "1" (seq.++ "." (seq.++ "t" (seq.++ "D" ""))))))
;witness2: "A9.z.ZZzYg"
(define-fun Witness2 () String (seq.++ "A" (seq.++ "9" (seq.++ "." (seq.++ "z" (seq.++ "." (seq.++ "Z" (seq.++ "Z" (seq.++ "z" (seq.++ "Y" (seq.++ "g" "")))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.+ (re.++ (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z")))(re.++ (re.opt (re.++ ((_ re.loop 0 61) (re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z"))))) (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z"))))) (re.range "." "."))))(re.++ ((_ re.loop 2 6) (re.union (re.range "A" "Z") (re.range "a" "z"))) (str.to_re ""))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
