;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^([A-Z]|[a-z]|[0-9])(([A-Z])*(([a-z])*([0-9])*(%)*(&)*(')*(\+)*(-)*(@)*(_)*(\.)*)|(\ )[^  ])+$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "Z8_...s"
(define-fun Witness1 () String (str.++ "Z" (str.++ "8" (str.++ "_" (str.++ "." (str.++ "." (str.++ "." (str.++ "s" ""))))))))
;witness2: "g \u00F8% c r"
(define-fun Witness2 () String (str.++ "g" (str.++ " " (str.++ "\u{f8}" (str.++ "%" (str.++ " " (str.++ "c" (str.++ " " (str.++ "r" "")))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z")))(re.++ (re.+ (re.union (re.++ (re.* (re.range "A" "Z")) (re.++ (re.* (re.range "a" "z"))(re.++ (re.* (re.range "0" "9"))(re.++ (re.* (re.range "%" "%"))(re.++ (re.* (re.range "&" "&"))(re.++ (re.* (re.range "'" "'"))(re.++ (re.* (re.range "+" "+"))(re.++ (re.* (re.range "-" "-"))(re.++ (re.* (re.range "@" "@"))(re.++ (re.* (re.range "_" "_")) (re.* (re.range "." ".")))))))))))) (re.++ (re.range " " " ") (re.union (re.range "\u{00}" "\u{1f}") (re.range "!" "\u{ff}"))))) (str.to_re ""))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
