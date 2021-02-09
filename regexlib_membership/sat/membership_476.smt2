;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(?:(?<scheme>[a-z]+):\/\/)?(?:(?<usern>[a-z0-9_.]*)(?::(?<passw>[a-z0-9_.]*))?@)?(?<domain>(?:(?:[a-z][a-z0-9_-]+\.?)+|[0-9]{1,3}(?:\.[0-9]{1,3}){3}))(?::(?<port>[0-9]+))?(?<path>(?:\/[.%a-z0-9_]*)+)?(?:\?(?<query>(?:&?[][a-z0-9_]+(?:\=?[a-z0-9_;]*)?)+))?(?:#(?<fragment>[a-z0-9_]+))?$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "a-/%"
(define-fun Witness1 () String (seq.++ "a" (seq.++ "-" (seq.++ "/" (seq.++ "%" "")))))
;witness2: "er://d8_:7?5e[990&eli[&3="
(define-fun Witness2 () String (seq.++ "e" (seq.++ "r" (seq.++ ":" (seq.++ "/" (seq.++ "/" (seq.++ "d" (seq.++ "8" (seq.++ "_" (seq.++ ":" (seq.++ "7" (seq.++ "?" (seq.++ "5" (seq.++ "e" (seq.++ "[" (seq.++ "9" (seq.++ "9" (seq.++ "0" (seq.++ "&" (seq.++ "e" (seq.++ "l" (seq.++ "i" (seq.++ "[" (seq.++ "&" (seq.++ "3" (seq.++ "=" ""))))))))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.opt (re.++ (re.+ (re.range "a" "z")) (str.to_re (seq.++ ":" (seq.++ "/" (seq.++ "/" ""))))))(re.++ (re.opt (re.++ (re.* (re.union (re.range "." ".")(re.union (re.range "0" "9")(re.union (re.range "_" "_") (re.range "a" "z")))))(re.++ (re.opt (re.++ (re.range ":" ":") (re.* (re.union (re.range "." ".")(re.union (re.range "0" "9")(re.union (re.range "_" "_") (re.range "a" "z"))))))) (re.range "@" "@"))))(re.++ (re.union (re.+ (re.++ (re.range "a" "z")(re.++ (re.+ (re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range "_" "_") (re.range "a" "z"))))) (re.opt (re.range "." "."))))) (re.++ ((_ re.loop 1 3) (re.range "0" "9")) ((_ re.loop 3 3) (re.++ (re.range "." ".") ((_ re.loop 1 3) (re.range "0" "9"))))))(re.++ (re.opt (re.++ (re.range ":" ":") (re.+ (re.range "0" "9"))))(re.++ (re.opt (re.+ (re.++ (re.range "/" "/") (re.* (re.union (re.range "%" "%")(re.union (re.range "." ".")(re.union (re.range "0" "9")(re.union (re.range "_" "_") (re.range "a" "z")))))))))(re.++ (re.opt (re.++ (re.range "?" "?") (re.+ (re.++ (re.opt (re.range "&" "&"))(re.++ (re.+ (re.union (re.range "0" "9")(re.union (re.range "[" "[")(re.union (re.range "]" "]")(re.union (re.range "_" "_") (re.range "a" "z")))))) (re.opt (re.++ (re.opt (re.range "=" "=")) (re.* (re.union (re.range "0" "9")(re.union (re.range ";" ";")(re.union (re.range "_" "_") (re.range "a" "z"))))))))))))(re.++ (re.opt (re.++ (re.range "#" "#") (re.+ (re.union (re.range "0" "9")(re.union (re.range "_" "_") (re.range "a" "z")))))) (str.to_re "")))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
