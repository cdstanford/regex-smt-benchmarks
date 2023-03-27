;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[\w-]+(?:\.[\w-]+)*@(?:[\w-]+\.)+[a-zA-Z]{2,7}$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "\u00AA.d@\u00AA.\u00BA.\u00CA.Rz.u.aAz"
(define-fun Witness1 () String (str.++ "\u{aa}" (str.++ "." (str.++ "d" (str.++ "@" (str.++ "\u{aa}" (str.++ "." (str.++ "\u{ba}" (str.++ "." (str.++ "\u{ca}" (str.++ "." (str.++ "R" (str.++ "z" (str.++ "." (str.++ "u" (str.++ "." (str.++ "a" (str.++ "A" (str.++ "z" "")))))))))))))))))))
;witness2: "7.-.\u00C6@\u00B5-_.aZLs"
(define-fun Witness2 () String (str.++ "7" (str.++ "." (str.++ "-" (str.++ "." (str.++ "\u{c6}" (str.++ "@" (str.++ "\u{b5}" (str.++ "-" (str.++ "_" (str.++ "." (str.++ "a" (str.++ "Z" (str.++ "L" (str.++ "s" "")))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.+ (re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\u{aa}" "\u{aa}")(re.union (re.range "\u{b5}" "\u{b5}")(re.union (re.range "\u{ba}" "\u{ba}")(re.union (re.range "\u{c0}" "\u{d6}")(re.union (re.range "\u{d8}" "\u{f6}") (re.range "\u{f8}" "\u{ff}"))))))))))))(re.++ (re.* (re.++ (re.range "." ".") (re.+ (re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\u{aa}" "\u{aa}")(re.union (re.range "\u{b5}" "\u{b5}")(re.union (re.range "\u{ba}" "\u{ba}")(re.union (re.range "\u{c0}" "\u{d6}")(re.union (re.range "\u{d8}" "\u{f6}") (re.range "\u{f8}" "\u{ff}"))))))))))))))(re.++ (re.range "@" "@")(re.++ (re.+ (re.++ (re.+ (re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\u{aa}" "\u{aa}")(re.union (re.range "\u{b5}" "\u{b5}")(re.union (re.range "\u{ba}" "\u{ba}")(re.union (re.range "\u{c0}" "\u{d6}")(re.union (re.range "\u{d8}" "\u{f6}") (re.range "\u{f8}" "\u{ff}")))))))))))) (re.range "." ".")))(re.++ ((_ re.loop 2 7) (re.union (re.range "A" "Z") (re.range "a" "z"))) (str.to_re "")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
