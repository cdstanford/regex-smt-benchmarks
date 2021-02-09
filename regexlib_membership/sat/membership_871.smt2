;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (?<protocol>http(s)?|ftp)://(?<server>([A-Za-z0-9-]+\.)*(?<basedomain>[A-Za-z0-9-]+\.[A-Za-z0-9]+))+((/?)(?<path>(?<dir>[A-Za-z0-9\._\-]+)(/){0,1}[A-Za-z0-9.-/]*)){0,1}
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "\u00F9\u00BA\u00B1S\u00C2\u0091ftp://x899.X87I--.9j.-tz.1-.8.--b--88.JN.98"
(define-fun Witness1 () String (seq.++ "\xf9" (seq.++ "\xba" (seq.++ "\xb1" (seq.++ "S" (seq.++ "\xc2" (seq.++ "\x91" (seq.++ "f" (seq.++ "t" (seq.++ "p" (seq.++ ":" (seq.++ "/" (seq.++ "/" (seq.++ "x" (seq.++ "8" (seq.++ "9" (seq.++ "9" (seq.++ "." (seq.++ "X" (seq.++ "8" (seq.++ "7" (seq.++ "I" (seq.++ "-" (seq.++ "-" (seq.++ "." (seq.++ "9" (seq.++ "j" (seq.++ "." (seq.++ "-" (seq.++ "t" (seq.++ "z" (seq.++ "." (seq.++ "1" (seq.++ "-" (seq.++ "." (seq.++ "8" (seq.++ "." (seq.++ "-" (seq.++ "-" (seq.++ "b" (seq.++ "-" (seq.++ "-" (seq.++ "8" (seq.++ "8" (seq.++ "." (seq.++ "J" (seq.++ "N" (seq.++ "." (seq.++ "9" (seq.++ "8" ""))))))))))))))))))))))))))))))))))))))))))))))))))
;witness2: "\x8n\u00E0\u00CD\u007F\u00BD\u00A8\u008Eftp://Z.XGw.fP9.-.6-I.-.y/_/LL\'\u00B0"
(define-fun Witness2 () String (seq.++ "\x08" (seq.++ "n" (seq.++ "\xe0" (seq.++ "\xcd" (seq.++ "\x7f" (seq.++ "\xbd" (seq.++ "\xa8" (seq.++ "\x8e" (seq.++ "f" (seq.++ "t" (seq.++ "p" (seq.++ ":" (seq.++ "/" (seq.++ "/" (seq.++ "Z" (seq.++ "." (seq.++ "X" (seq.++ "G" (seq.++ "w" (seq.++ "." (seq.++ "f" (seq.++ "P" (seq.++ "9" (seq.++ "." (seq.++ "-" (seq.++ "." (seq.++ "6" (seq.++ "-" (seq.++ "I" (seq.++ "." (seq.++ "-" (seq.++ "." (seq.++ "y" (seq.++ "/" (seq.++ "_" (seq.++ "/" (seq.++ "L" (seq.++ "L" (seq.++ "'" (seq.++ "\xb0" "")))))))))))))))))))))))))))))))))))))))))

(assert (= regexA (re.++ (re.union (re.++ (str.to_re (seq.++ "h" (seq.++ "t" (seq.++ "t" (seq.++ "p" ""))))) (re.opt (re.range "s" "s"))) (str.to_re (seq.++ "f" (seq.++ "t" (seq.++ "p" "")))))(re.++ (str.to_re (seq.++ ":" (seq.++ "/" (seq.++ "/" ""))))(re.++ (re.+ (re.++ (re.* (re.++ (re.+ (re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z"))))) (re.range "." "."))) (re.++ (re.+ (re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z")))))(re.++ (re.range "." ".") (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z")))))))) (re.opt (re.++ (re.opt (re.range "/" "/")) (re.++ (re.+ (re.union (re.range "-" ".")(re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_") (re.range "a" "z"))))))(re.++ (re.opt (re.range "/" "/")) (re.* (re.union (re.range "." "9")(re.union (re.range "A" "Z") (re.range "a" "z")))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
