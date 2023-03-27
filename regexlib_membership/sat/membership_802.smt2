;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = https?://[\w./]+\/[\w./]+\.(bmp|png|jpg|gif)
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "4http://\u00AA\u00BA\u00AA/Sz\u00DB\u00BA\u00AA\u00BA.gif\u0090a\xC"
(define-fun Witness1 () String (str.++ "4" (str.++ "h" (str.++ "t" (str.++ "t" (str.++ "p" (str.++ ":" (str.++ "/" (str.++ "/" (str.++ "\u{aa}" (str.++ "\u{ba}" (str.++ "\u{aa}" (str.++ "/" (str.++ "S" (str.++ "z" (str.++ "\u{db}" (str.++ "\u{ba}" (str.++ "\u{aa}" (str.++ "\u{ba}" (str.++ "." (str.++ "g" (str.++ "i" (str.++ "f" (str.++ "\u{90}" (str.++ "a" (str.++ "\u{0c}" ""))))))))))))))))))))))))))
;witness2: "\u00B0https://j\u00B5./\u00B5.gifl"
(define-fun Witness2 () String (str.++ "\u{b0}" (str.++ "h" (str.++ "t" (str.++ "t" (str.++ "p" (str.++ "s" (str.++ ":" (str.++ "/" (str.++ "/" (str.++ "j" (str.++ "\u{b5}" (str.++ "." (str.++ "/" (str.++ "\u{b5}" (str.++ "." (str.++ "g" (str.++ "i" (str.++ "f" (str.++ "l" ""))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re (str.++ "h" (str.++ "t" (str.++ "t" (str.++ "p" "")))))(re.++ (re.opt (re.range "s" "s"))(re.++ (str.to_re (str.++ ":" (str.++ "/" (str.++ "/" ""))))(re.++ (re.+ (re.union (re.range "." "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\u{aa}" "\u{aa}")(re.union (re.range "\u{b5}" "\u{b5}")(re.union (re.range "\u{ba}" "\u{ba}")(re.union (re.range "\u{c0}" "\u{d6}")(re.union (re.range "\u{d8}" "\u{f6}") (re.range "\u{f8}" "\u{ff}")))))))))))(re.++ (re.range "/" "/")(re.++ (re.+ (re.union (re.range "." "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\u{aa}" "\u{aa}")(re.union (re.range "\u{b5}" "\u{b5}")(re.union (re.range "\u{ba}" "\u{ba}")(re.union (re.range "\u{c0}" "\u{d6}")(re.union (re.range "\u{d8}" "\u{f6}") (re.range "\u{f8}" "\u{ff}")))))))))))(re.++ (re.range "." ".") (re.union (str.to_re (str.++ "b" (str.++ "m" (str.++ "p" ""))))(re.union (str.to_re (str.++ "p" (str.++ "n" (str.++ "g" ""))))(re.union (str.to_re (str.++ "j" (str.++ "p" (str.++ "g" "")))) (str.to_re (str.++ "g" (str.++ "i" (str.++ "f" ""))))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
