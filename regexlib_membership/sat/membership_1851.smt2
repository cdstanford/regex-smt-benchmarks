;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(([-\w \.]+)|(&quot;&quot;[-\w \.]+&quot;&quot;) )?&lt;([\w\-\.]+)@((\[([0-9]{1,3}\.){3}[0-9]{1,3}\])|(([\w\-]+\.)+)([a-zA-Z]{2,4}))&gt;$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "5b8\u00AA&lt;\u00FA@-9.\u00B5\u00C4-\u00FE\u00BA\u00E4\u00CA5.c\u00AA.\u00E7\u00B5.EH&gt;"
(define-fun Witness1 () String (str.++ "5" (str.++ "b" (str.++ "8" (str.++ "\u{aa}" (str.++ "&" (str.++ "l" (str.++ "t" (str.++ ";" (str.++ "\u{fa}" (str.++ "@" (str.++ "-" (str.++ "9" (str.++ "." (str.++ "\u{b5}" (str.++ "\u{c4}" (str.++ "-" (str.++ "\u{fe}" (str.++ "\u{ba}" (str.++ "\u{e4}" (str.++ "\u{ca}" (str.++ "5" (str.++ "." (str.++ "c" (str.++ "\u{aa}" (str.++ "." (str.++ "\u{e7}" (str.++ "\u{b5}" (str.++ "." (str.++ "E" (str.++ "H" (str.++ "&" (str.++ "g" (str.++ "t" (str.++ ";" "")))))))))))))))))))))))))))))))))))
;witness2: "&lt;C4@9.\u00EA.ZkS&gt;"
(define-fun Witness2 () String (str.++ "&" (str.++ "l" (str.++ "t" (str.++ ";" (str.++ "C" (str.++ "4" (str.++ "@" (str.++ "9" (str.++ "." (str.++ "\u{ea}" (str.++ "." (str.++ "Z" (str.++ "k" (str.++ "S" (str.++ "&" (str.++ "g" (str.++ "t" (str.++ ";" "")))))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.opt (re.union (re.+ (re.union (re.range " " " ")(re.union (re.range "-" ".")(re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\u{aa}" "\u{aa}")(re.union (re.range "\u{b5}" "\u{b5}")(re.union (re.range "\u{ba}" "\u{ba}")(re.union (re.range "\u{c0}" "\u{d6}")(re.union (re.range "\u{d8}" "\u{f6}") (re.range "\u{f8}" "\u{ff}"))))))))))))) (re.++ (re.++ (str.to_re (str.++ "&" (str.++ "q" (str.++ "u" (str.++ "o" (str.++ "t" (str.++ ";" (str.++ "&" (str.++ "q" (str.++ "u" (str.++ "o" (str.++ "t" (str.++ ";" "")))))))))))))(re.++ (re.+ (re.union (re.range " " " ")(re.union (re.range "-" ".")(re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\u{aa}" "\u{aa}")(re.union (re.range "\u{b5}" "\u{b5}")(re.union (re.range "\u{ba}" "\u{ba}")(re.union (re.range "\u{c0}" "\u{d6}")(re.union (re.range "\u{d8}" "\u{f6}") (re.range "\u{f8}" "\u{ff}"))))))))))))) (str.to_re (str.++ "&" (str.++ "q" (str.++ "u" (str.++ "o" (str.++ "t" (str.++ ";" (str.++ "&" (str.++ "q" (str.++ "u" (str.++ "o" (str.++ "t" (str.++ ";" ""))))))))))))))) (re.range " " " "))))(re.++ (str.to_re (str.++ "&" (str.++ "l" (str.++ "t" (str.++ ";" "")))))(re.++ (re.+ (re.union (re.range "-" ".")(re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\u{aa}" "\u{aa}")(re.union (re.range "\u{b5}" "\u{b5}")(re.union (re.range "\u{ba}" "\u{ba}")(re.union (re.range "\u{c0}" "\u{d6}")(re.union (re.range "\u{d8}" "\u{f6}") (re.range "\u{f8}" "\u{ff}"))))))))))))(re.++ (re.range "@" "@")(re.++ (re.union (re.++ (re.range "[" "[")(re.++ ((_ re.loop 3 3) (re.++ ((_ re.loop 1 3) (re.range "0" "9")) (re.range "." ".")))(re.++ ((_ re.loop 1 3) (re.range "0" "9")) (re.range "]" "]")))) (re.++ (re.+ (re.++ (re.+ (re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\u{aa}" "\u{aa}")(re.union (re.range "\u{b5}" "\u{b5}")(re.union (re.range "\u{ba}" "\u{ba}")(re.union (re.range "\u{c0}" "\u{d6}")(re.union (re.range "\u{d8}" "\u{f6}") (re.range "\u{f8}" "\u{ff}")))))))))))) (re.range "." "."))) ((_ re.loop 2 4) (re.union (re.range "A" "Z") (re.range "a" "z")))))(re.++ (str.to_re (str.++ "&" (str.++ "g" (str.++ "t" (str.++ ";" ""))))) (str.to_re ""))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
