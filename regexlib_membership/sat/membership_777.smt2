;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(([-\w$%&'*+\/=?^_`{|}~.]+)@(([-a-zA-Z0-9_]+\.)*)([-a-zA-Z0-9]+\.)([a-zA-Z0-9]{2,7}))?$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "\u00C2@LA8-K.va8Z"
(define-fun Witness1 () String (str.++ "\u{c2}" (str.++ "@" (str.++ "L" (str.++ "A" (str.++ "8" (str.++ "-" (str.++ "K" (str.++ "." (str.++ "v" (str.++ "a" (str.++ "8" (str.++ "Z" "")))))))))))))
;witness2: ""
(define-fun Witness2 () String "")

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.opt (re.++ (re.+ (re.union (re.range "$" "'")(re.union (re.range "*" "+")(re.union (re.range "-" "9")(re.union (re.range "=" "=")(re.union (re.range "?" "?")(re.union (re.range "A" "Z")(re.union (re.range "^" "~")(re.union (re.range "\u{aa}" "\u{aa}")(re.union (re.range "\u{b5}" "\u{b5}")(re.union (re.range "\u{ba}" "\u{ba}")(re.union (re.range "\u{c0}" "\u{d6}")(re.union (re.range "\u{d8}" "\u{f6}") (re.range "\u{f8}" "\u{ff}"))))))))))))))(re.++ (re.range "@" "@")(re.++ (re.* (re.++ (re.+ (re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_") (re.range "a" "z")))))) (re.range "." ".")))(re.++ (re.++ (re.+ (re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z"))))) (re.range "." ".")) ((_ re.loop 2 7) (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z"))))))))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
