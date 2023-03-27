;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^http://\w{0,3}.?youtube+\.\w{2,3}/watch\?v=[\w-]{11}
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "http://youtube.8\u00F5/watch?v=8-\u00AAPG\u00E7\u00AAh8\u00AA\u00BA\u00D4"
(define-fun Witness1 () String (str.++ "h" (str.++ "t" (str.++ "t" (str.++ "p" (str.++ ":" (str.++ "/" (str.++ "/" (str.++ "y" (str.++ "o" (str.++ "u" (str.++ "t" (str.++ "u" (str.++ "b" (str.++ "e" (str.++ "." (str.++ "8" (str.++ "\u{f5}" (str.++ "/" (str.++ "w" (str.++ "a" (str.++ "t" (str.++ "c" (str.++ "h" (str.++ "?" (str.++ "v" (str.++ "=" (str.++ "8" (str.++ "-" (str.++ "\u{aa}" (str.++ "P" (str.++ "G" (str.++ "\u{e7}" (str.++ "\u{aa}" (str.++ "h" (str.++ "8" (str.++ "\u{aa}" (str.++ "\u{ba}" (str.++ "\u{d4}" "")))))))))))))))))))))))))))))))))))))))
;witness2: "http://i\u00E1youtubee.A6\u00AA/watch?v=-\u00AA\u00B5\u00BA\u00FB_iZ-9c"
(define-fun Witness2 () String (str.++ "h" (str.++ "t" (str.++ "t" (str.++ "p" (str.++ ":" (str.++ "/" (str.++ "/" (str.++ "i" (str.++ "\u{e1}" (str.++ "y" (str.++ "o" (str.++ "u" (str.++ "t" (str.++ "u" (str.++ "b" (str.++ "e" (str.++ "e" (str.++ "." (str.++ "A" (str.++ "6" (str.++ "\u{aa}" (str.++ "/" (str.++ "w" (str.++ "a" (str.++ "t" (str.++ "c" (str.++ "h" (str.++ "?" (str.++ "v" (str.++ "=" (str.++ "-" (str.++ "\u{aa}" (str.++ "\u{b5}" (str.++ "\u{ba}" (str.++ "\u{fb}" (str.++ "_" (str.++ "i" (str.++ "Z" (str.++ "-" (str.++ "9" (str.++ "c" ""))))))))))))))))))))))))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (str.to_re (str.++ "h" (str.++ "t" (str.++ "t" (str.++ "p" (str.++ ":" (str.++ "/" (str.++ "/" ""))))))))(re.++ ((_ re.loop 0 3) (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\u{aa}" "\u{aa}")(re.union (re.range "\u{b5}" "\u{b5}")(re.union (re.range "\u{ba}" "\u{ba}")(re.union (re.range "\u{c0}" "\u{d6}")(re.union (re.range "\u{d8}" "\u{f6}") (re.range "\u{f8}" "\u{ff}")))))))))))(re.++ (re.opt (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}")))(re.++ (str.to_re (str.++ "y" (str.++ "o" (str.++ "u" (str.++ "t" (str.++ "u" (str.++ "b" "")))))))(re.++ (re.+ (re.range "e" "e"))(re.++ (re.range "." ".")(re.++ ((_ re.loop 2 3) (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\u{aa}" "\u{aa}")(re.union (re.range "\u{b5}" "\u{b5}")(re.union (re.range "\u{ba}" "\u{ba}")(re.union (re.range "\u{c0}" "\u{d6}")(re.union (re.range "\u{d8}" "\u{f6}") (re.range "\u{f8}" "\u{ff}")))))))))))(re.++ (str.to_re (str.++ "/" (str.++ "w" (str.++ "a" (str.++ "t" (str.++ "c" (str.++ "h" (str.++ "?" (str.++ "v" (str.++ "=" "")))))))))) ((_ re.loop 11 11) (re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\u{aa}" "\u{aa}")(re.union (re.range "\u{b5}" "\u{b5}")(re.union (re.range "\u{ba}" "\u{ba}")(re.union (re.range "\u{c0}" "\u{d6}")(re.union (re.range "\u{d8}" "\u{f6}") (re.range "\u{f8}" "\u{ff}")))))))))))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
