;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(?<Assembly>(?<AssemblyName>[^\W/\\:*?"<>|,]+)(?:(?:,\s?(?:(?<Version>Version=(?<VersionValue>(?:\d{1,2}\.?){1,4}))|(?<Culture>Culture=(?<CultureValue>neutral|\w{2}-\w{2}))|(?<PublicKeyToken>PublicKeyToken=(?<PublicKeyTokenValue>[A-Fa-f0-9]{16})))(?:,\s?)?){3}|))$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "\u00FE\u00ED5"
(define-fun Witness1 () String (str.++ "\u{fe}" (str.++ "\u{ed}" (str.++ "5" ""))))
;witness2: "\u00E2"
(define-fun Witness2 () String (str.++ "\u{e2}" ""))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.++ (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\u{aa}" "\u{aa}")(re.union (re.range "\u{b5}" "\u{b5}")(re.union (re.range "\u{ba}" "\u{ba}")(re.union (re.range "\u{c0}" "\u{d6}")(re.union (re.range "\u{d8}" "\u{f6}") (re.range "\u{f8}" "\u{ff}"))))))))))) (re.union ((_ re.loop 3 3) (re.++ (re.range "," ",")(re.++ (re.opt (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ (re.union (re.++ (str.to_re (str.++ "V" (str.++ "e" (str.++ "r" (str.++ "s" (str.++ "i" (str.++ "o" (str.++ "n" (str.++ "=" ""))))))))) ((_ re.loop 1 4) (re.++ ((_ re.loop 1 2) (re.range "0" "9")) (re.opt (re.range "." ".")))))(re.union (re.++ (str.to_re (str.++ "C" (str.++ "u" (str.++ "l" (str.++ "t" (str.++ "u" (str.++ "r" (str.++ "e" (str.++ "=" ""))))))))) (re.union (str.to_re (str.++ "n" (str.++ "e" (str.++ "u" (str.++ "t" (str.++ "r" (str.++ "a" (str.++ "l" "")))))))) (re.++ ((_ re.loop 2 2) (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\u{aa}" "\u{aa}")(re.union (re.range "\u{b5}" "\u{b5}")(re.union (re.range "\u{ba}" "\u{ba}")(re.union (re.range "\u{c0}" "\u{d6}")(re.union (re.range "\u{d8}" "\u{f6}") (re.range "\u{f8}" "\u{ff}")))))))))))(re.++ (re.range "-" "-") ((_ re.loop 2 2) (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\u{aa}" "\u{aa}")(re.union (re.range "\u{b5}" "\u{b5}")(re.union (re.range "\u{ba}" "\u{ba}")(re.union (re.range "\u{c0}" "\u{d6}")(re.union (re.range "\u{d8}" "\u{f6}") (re.range "\u{f8}" "\u{ff}"))))))))))))))) (re.++ (str.to_re (str.++ "P" (str.++ "u" (str.++ "b" (str.++ "l" (str.++ "i" (str.++ "c" (str.++ "K" (str.++ "e" (str.++ "y" (str.++ "T" (str.++ "o" (str.++ "k" (str.++ "e" (str.++ "n" (str.++ "=" "")))))))))))))))) ((_ re.loop 16 16) (re.union (re.range "0" "9")(re.union (re.range "A" "F") (re.range "a" "f"))))))) (re.opt (re.++ (re.range "," ",") (re.opt (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}"))))))))))) (str.to_re ""))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
