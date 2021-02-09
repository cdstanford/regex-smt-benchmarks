;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(?<Assembly>(?<AssemblyName>[^\W/\\:*?"<>|,]+)(?:(?:,\s?(?:(?<Version>Version=(?<VersionValue>(?:\d{1,2}\.?){1,4}))|(?<Culture>Culture=(?<CultureValue>neutral|\w{2}-\w{2}))|(?<PublicKeyToken>PublicKeyToken=(?<PublicKeyTokenValue>[A-Fa-f0-9]{16})))(?:,\s?)?){3}|))$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "\u00FE\u00ED5"
(define-fun Witness1 () String (seq.++ "\xfe" (seq.++ "\xed" (seq.++ "5" ""))))
;witness2: "\u00E2"
(define-fun Witness2 () String (seq.++ "\xe2" ""))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.++ (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff"))))))))))) (re.union ((_ re.loop 3 3) (re.++ (re.range "," ",")(re.++ (re.opt (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))(re.++ (re.union (re.++ (str.to_re (seq.++ "V" (seq.++ "e" (seq.++ "r" (seq.++ "s" (seq.++ "i" (seq.++ "o" (seq.++ "n" (seq.++ "=" ""))))))))) ((_ re.loop 1 4) (re.++ ((_ re.loop 1 2) (re.range "0" "9")) (re.opt (re.range "." ".")))))(re.union (re.++ (str.to_re (seq.++ "C" (seq.++ "u" (seq.++ "l" (seq.++ "t" (seq.++ "u" (seq.++ "r" (seq.++ "e" (seq.++ "=" ""))))))))) (re.union (str.to_re (seq.++ "n" (seq.++ "e" (seq.++ "u" (seq.++ "t" (seq.++ "r" (seq.++ "a" (seq.++ "l" "")))))))) (re.++ ((_ re.loop 2 2) (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff")))))))))))(re.++ (re.range "-" "-") ((_ re.loop 2 2) (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff"))))))))))))))) (re.++ (str.to_re (seq.++ "P" (seq.++ "u" (seq.++ "b" (seq.++ "l" (seq.++ "i" (seq.++ "c" (seq.++ "K" (seq.++ "e" (seq.++ "y" (seq.++ "T" (seq.++ "o" (seq.++ "k" (seq.++ "e" (seq.++ "n" (seq.++ "=" "")))))))))))))))) ((_ re.loop 16 16) (re.union (re.range "0" "9")(re.union (re.range "A" "F") (re.range "a" "f"))))))) (re.opt (re.++ (re.range "," ",") (re.opt (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))))))))) (str.to_re ""))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
