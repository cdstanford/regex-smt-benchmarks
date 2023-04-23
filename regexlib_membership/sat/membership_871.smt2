;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (?<protocol>http(s)?|ftp)://(?<server>([A-Za-z0-9-]+\.)*(?<basedomain>[A-Za-z0-9-]+\.[A-Za-z0-9]+))+((/?)(?<path>(?<dir>[A-Za-z0-9\._\-]+)(/){0,1}[A-Za-z0-9.-/]*)){0,1}
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "\u00F9\u00BA\u00B1S\u00C2\u0091ftp://x899.X87I--.9j.-tz.1-.8.--b--88.JN.98"
(define-fun Witness1 () String (str.++ "\u{f9}" (str.++ "\u{ba}" (str.++ "\u{b1}" (str.++ "S" (str.++ "\u{c2}" (str.++ "\u{91}" (str.++ "f" (str.++ "t" (str.++ "p" (str.++ ":" (str.++ "/" (str.++ "/" (str.++ "x" (str.++ "8" (str.++ "9" (str.++ "9" (str.++ "." (str.++ "X" (str.++ "8" (str.++ "7" (str.++ "I" (str.++ "-" (str.++ "-" (str.++ "." (str.++ "9" (str.++ "j" (str.++ "." (str.++ "-" (str.++ "t" (str.++ "z" (str.++ "." (str.++ "1" (str.++ "-" (str.++ "." (str.++ "8" (str.++ "." (str.++ "-" (str.++ "-" (str.++ "b" (str.++ "-" (str.++ "-" (str.++ "8" (str.++ "8" (str.++ "." (str.++ "J" (str.++ "N" (str.++ "." (str.++ "9" (str.++ "8" ""))))))))))))))))))))))))))))))))))))))))))))))))))
;witness2: "\x8n\u00E0\u00CD\u007F\u00BD\u00A8\u008Eftp://Z.XGw.fP9.-.6-I.-.y/_/LL\'\u00B0"
(define-fun Witness2 () String (str.++ "\u{08}" (str.++ "n" (str.++ "\u{e0}" (str.++ "\u{cd}" (str.++ "\u{7f}" (str.++ "\u{bd}" (str.++ "\u{a8}" (str.++ "\u{8e}" (str.++ "f" (str.++ "t" (str.++ "p" (str.++ ":" (str.++ "/" (str.++ "/" (str.++ "Z" (str.++ "." (str.++ "X" (str.++ "G" (str.++ "w" (str.++ "." (str.++ "f" (str.++ "P" (str.++ "9" (str.++ "." (str.++ "-" (str.++ "." (str.++ "6" (str.++ "-" (str.++ "I" (str.++ "." (str.++ "-" (str.++ "." (str.++ "y" (str.++ "/" (str.++ "_" (str.++ "/" (str.++ "L" (str.++ "L" (str.++ "'" (str.++ "\u{b0}" "")))))))))))))))))))))))))))))))))))))))))

(assert (= regexA (re.++ (re.union (re.++ (str.to_re (str.++ "h" (str.++ "t" (str.++ "t" (str.++ "p" ""))))) (re.opt (re.range "s" "s"))) (str.to_re (str.++ "f" (str.++ "t" (str.++ "p" "")))))(re.++ (str.to_re (str.++ ":" (str.++ "/" (str.++ "/" ""))))(re.++ (re.+ (re.++ (re.* (re.++ (re.+ (re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z"))))) (re.range "." "."))) (re.++ (re.+ (re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z")))))(re.++ (re.range "." ".") (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z")))))))) (re.opt (re.++ (re.opt (re.range "/" "/")) (re.++ (re.+ (re.union (re.range "-" ".")(re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_") (re.range "a" "z"))))))(re.++ (re.opt (re.range "/" "/")) (re.* (re.union (re.range "." "9")(re.union (re.range "A" "Z") (re.range "a" "z")))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
