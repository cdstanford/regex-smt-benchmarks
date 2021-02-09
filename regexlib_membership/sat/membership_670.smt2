;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ([0-9a-z_-]+[\.][0-9a-z_-]{1,3})$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "9._-"
(define-fun Witness1 () String (seq.++ "9" (seq.++ "." (seq.++ "_" (seq.++ "-" "")))))
;witness2: "6\u00E8m_.8"
(define-fun Witness2 () String (seq.++ "6" (seq.++ "\xe8" (seq.++ "m" (seq.++ "_" (seq.++ "." (seq.++ "8" "")))))))

(assert (= regexA (re.++ (re.++ (re.+ (re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range "_" "_") (re.range "a" "z")))))(re.++ (re.range "." ".") ((_ re.loop 1 3) (re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range "_" "_") (re.range "a" "z"))))))) (str.to_re ""))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
