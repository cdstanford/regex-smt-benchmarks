;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^([A-Z]|[a-z]|[0-9])(([A-Z])*(([a-z])*([0-9])*(%)*(&)*(')*(\+)*(-)*(@)*(_)*(\.)*)|(\ )[^  ])+$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "Z8_...s"
(define-fun Witness1 () String (seq.++ "Z" (seq.++ "8" (seq.++ "_" (seq.++ "." (seq.++ "." (seq.++ "." (seq.++ "s" ""))))))))
;witness2: "g \u00F8% c r"
(define-fun Witness2 () String (seq.++ "g" (seq.++ " " (seq.++ "\xf8" (seq.++ "%" (seq.++ " " (seq.++ "c" (seq.++ " " (seq.++ "r" "")))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z")))(re.++ (re.+ (re.union (re.++ (re.* (re.range "A" "Z")) (re.++ (re.* (re.range "a" "z"))(re.++ (re.* (re.range "0" "9"))(re.++ (re.* (re.range "%" "%"))(re.++ (re.* (re.range "&" "&"))(re.++ (re.* (re.range "'" "'"))(re.++ (re.* (re.range "+" "+"))(re.++ (re.* (re.range "-" "-"))(re.++ (re.* (re.range "@" "@"))(re.++ (re.* (re.range "_" "_")) (re.* (re.range "." ".")))))))))))) (re.++ (re.range " " " ") (re.union (re.range "\x00" "\x1f") (re.range "!" "\xff"))))) (str.to_re ""))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
