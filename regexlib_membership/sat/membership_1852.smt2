;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^([\w\-\.]+)@((\[([0-9]{1,3}\.){3}[0-9]{1,3}\])|(([\w\-]+\.)+)([a-zA-Z]{2,4}))$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "\u00DB\u00DD-.@[45.9.8.892]"
(define-fun Witness1 () String (str.++ "\u{db}" (str.++ "\u{dd}" (str.++ "-" (str.++ "." (str.++ "@" (str.++ "[" (str.++ "4" (str.++ "5" (str.++ "." (str.++ "9" (str.++ "." (str.++ "8" (str.++ "." (str.++ "8" (str.++ "9" (str.++ "2" (str.++ "]" ""))))))))))))))))))
;witness2: "\u00BA@\u00AA.Eu-7\u00F5\u00B5.DxwQ"
(define-fun Witness2 () String (str.++ "\u{ba}" (str.++ "@" (str.++ "\u{aa}" (str.++ "." (str.++ "E" (str.++ "u" (str.++ "-" (str.++ "7" (str.++ "\u{f5}" (str.++ "\u{b5}" (str.++ "." (str.++ "D" (str.++ "x" (str.++ "w" (str.++ "Q" ""))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.+ (re.union (re.range "-" ".")(re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\u{aa}" "\u{aa}")(re.union (re.range "\u{b5}" "\u{b5}")(re.union (re.range "\u{ba}" "\u{ba}")(re.union (re.range "\u{c0}" "\u{d6}")(re.union (re.range "\u{d8}" "\u{f6}") (re.range "\u{f8}" "\u{ff}"))))))))))))(re.++ (re.range "@" "@")(re.++ (re.union (re.++ (re.range "[" "[")(re.++ ((_ re.loop 3 3) (re.++ ((_ re.loop 1 3) (re.range "0" "9")) (re.range "." ".")))(re.++ ((_ re.loop 1 3) (re.range "0" "9")) (re.range "]" "]")))) (re.++ (re.+ (re.++ (re.+ (re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\u{aa}" "\u{aa}")(re.union (re.range "\u{b5}" "\u{b5}")(re.union (re.range "\u{ba}" "\u{ba}")(re.union (re.range "\u{c0}" "\u{d6}")(re.union (re.range "\u{d8}" "\u{f6}") (re.range "\u{f8}" "\u{ff}")))))))))))) (re.range "." "."))) ((_ re.loop 2 4) (re.union (re.range "A" "Z") (re.range "a" "z"))))) (str.to_re "")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
