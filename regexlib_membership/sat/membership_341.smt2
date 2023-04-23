;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[a-z0-9,!#\$%&'\*\+/=\?\^_`\{\|}~-]+(\.[a-z0-9,!#\$%&'\*\+/=\?\^_`\{\|}~-]+)*@[a-z0-9-]+(\.[a-z0-9-]+)*\.([a-z]{2,})$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "}@8.spr"
(define-fun Witness1 () String (str.++ "}" (str.++ "@" (str.++ "8" (str.++ "." (str.++ "s" (str.++ "p" (str.++ "r" ""))))))))
;witness2: "&@8o.ct"
(define-fun Witness2 () String (str.++ "&" (str.++ "@" (str.++ "8" (str.++ "o" (str.++ "." (str.++ "c" (str.++ "t" ""))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.+ (re.union (re.range "!" "!")(re.union (re.range "#" "'")(re.union (re.range "*" "-")(re.union (re.range "/" "9")(re.union (re.range "=" "=")(re.union (re.range "?" "?") (re.range "^" "~"))))))))(re.++ (re.* (re.++ (re.range "." ".") (re.+ (re.union (re.range "!" "!")(re.union (re.range "#" "'")(re.union (re.range "*" "-")(re.union (re.range "/" "9")(re.union (re.range "=" "=")(re.union (re.range "?" "?") (re.range "^" "~"))))))))))(re.++ (re.range "@" "@")(re.++ (re.+ (re.union (re.range "-" "-")(re.union (re.range "0" "9") (re.range "a" "z"))))(re.++ (re.* (re.++ (re.range "." ".") (re.+ (re.union (re.range "-" "-")(re.union (re.range "0" "9") (re.range "a" "z"))))))(re.++ (re.range "." ".")(re.++ (re.++ ((_ re.loop 2 2) (re.range "a" "z")) (re.* (re.range "a" "z"))) (str.to_re "")))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
