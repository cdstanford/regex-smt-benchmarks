;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ([A-Z]:\\[^/:\*\?<>\|]+\.\w{2,6})|(\\{2}[^/:\*\?<>\|]+\.\w{2,6})
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "\x1\u00A8%L:\\x18\x9.9x\u00C6"
(define-fun Witness1 () String (str.++ "\u{01}" (str.++ "\u{a8}" (str.++ "%" (str.++ "L" (str.++ ":" (str.++ "\u{5c}" (str.++ "\u{18}" (str.++ "\u{09}" (str.++ "." (str.++ "9" (str.++ "x" (str.++ "\u{c6}" "")))))))))))))
;witness2: "CY\x11R:\H.e\u00C9jB\u00EE9*J"
(define-fun Witness2 () String (str.++ "C" (str.++ "Y" (str.++ "\u{11}" (str.++ "R" (str.++ ":" (str.++ "\u{5c}" (str.++ "H" (str.++ "." (str.++ "e" (str.++ "\u{c9}" (str.++ "j" (str.++ "B" (str.++ "\u{ee}" (str.++ "9" (str.++ "*" (str.++ "J" "")))))))))))))))))

(assert (= regexA (re.union (re.++ (re.range "A" "Z")(re.++ (str.to_re (str.++ ":" (str.++ "\u{5c}" "")))(re.++ (re.+ (re.union (re.range "\u{00}" ")")(re.union (re.range "+" ".")(re.union (re.range "0" "9")(re.union (re.range ";" ";")(re.union (re.range "=" "=")(re.union (re.range "@" "{") (re.range "}" "\u{ff}"))))))))(re.++ (re.range "." ".") ((_ re.loop 2 6) (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\u{aa}" "\u{aa}")(re.union (re.range "\u{b5}" "\u{b5}")(re.union (re.range "\u{ba}" "\u{ba}")(re.union (re.range "\u{c0}" "\u{d6}")(re.union (re.range "\u{d8}" "\u{f6}") (re.range "\u{f8}" "\u{ff}"))))))))))))))) (re.++ ((_ re.loop 2 2) (re.range "\u{5c}" "\u{5c}"))(re.++ (re.+ (re.union (re.range "\u{00}" ")")(re.union (re.range "+" ".")(re.union (re.range "0" "9")(re.union (re.range ";" ";")(re.union (re.range "=" "=")(re.union (re.range "@" "{") (re.range "}" "\u{ff}"))))))))(re.++ (re.range "." ".") ((_ re.loop 2 6) (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\u{aa}" "\u{aa}")(re.union (re.range "\u{b5}" "\u{b5}")(re.union (re.range "\u{ba}" "\u{ba}")(re.union (re.range "\u{c0}" "\u{d6}")(re.union (re.range "\u{d8}" "\u{f6}") (re.range "\u{f8}" "\u{ff}")))))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
